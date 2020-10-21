//
//  BreedQuizViewModel.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 03.10.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation
import CoreData

class BreedQuizViewModel: BreedQuizViewModelType {

    var context: NSManagedObjectContext
    var fetcher: DataFetcher

    var currentBreed: BreedResponse?
    var breedImage: BreedImageResponse?

    var buttonText: [String] = []
    var updateViewData: ((BreedQuizData) -> Void)?

    init(context: NSManagedObjectContext, fetcher: DataFetcher = NetworkDataFetcher()) {
        self.fetcher = fetcher
        self.context = context
    }

    func getData() {
        fetcher.getBreed { [weak self] breeds in
            guard let breeds = breeds, let self = self else { return }

            let currentBreed = self.chooseCorrectBreed(breeds: breeds)
            self.currentBreed = currentBreed
            let buttonTextArray = self.configButtonTextArray(breeds: breeds, currentBreed: currentBreed)

            self.fetcher.getImageUrl(currentBreed) { imageResponse in
                guard let image = imageResponse?.first else { return }
                self.breedImage = image

                let breedQuizData = BreedQuizData.Data(imageUrl: image.url,
                                                       buttonTextArray: buttonTextArray)
                self.updateViewData?(.loading(breedQuizData))
            }
        }
    }

    func checkAnswer(answer: BreedQuizData.Answer) {
        guard let currentBreed = currentBreed else { return }
        if currentBreed.name == answer.answer {
            var checkedAnswer = answer
            checkedAnswer.correctAnswer = answer.answer
            checkedAnswer.isCorrect = true
            changeStatistic(isCorretAnswer: true)
            updateViewData?(.checkedAnswer(checkedAnswer))
        } else {
            var checkedAnswer = answer
            checkedAnswer.correctAnswer = currentBreed.name
            changeStatistic(isCorretAnswer: false)
            updateViewData?(.checkedAnswer(checkedAnswer))
        }
    }

    private func changeStatistic(isCorretAnswer: Bool) {
        guard let statistic = fetchStatistic() else { return }
        statistic.totalPlayed += 1

        if isCorretAnswer { statistic.winning += 1 }
        statistic.lastGame = Date()

        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    private func fetchStatistic() -> QuizStatistic? {
        let fetchRequest: NSFetchRequest<QuizStatistic> = QuizStatistic.fetchRequest()
        do {
            let statistic = try context.fetch(fetchRequest)
            if statistic.isEmpty {
                let statistic = QuizStatistic(context: context)
                statistic.totalPlayed = 0
                statistic.winning = 0
                try context.save()
                return statistic
            } else {
                return statistic.first
            }
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }

    private func chooseCorrectBreed(breeds: [BreedResponse]) -> BreedResponse {
        guard let breed = breeds.randomElement() else { return breeds[0]}
        return breed
    }

    private func configButtonTextArray(breeds: [BreedResponse], currentBreed: BreedResponse) -> [String] {
        var stringArray = [String]()
        for _ in 0...4 where stringArray.count < 3 {
            guard let breed = breeds.randomElement() else { return [""]}
            if breed.id != currentBreed.id {
                stringArray.append(breed.name)
            }
        }
        stringArray.append(currentBreed.name)
        return stringArray
    }
}
