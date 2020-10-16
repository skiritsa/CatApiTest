//
//  BreedQuizViewModel.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 03.10.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation

class BreedQuizViewModel: BreedQuizViewModelType {

    var fetcher: DataFetcher
    var currentBreed: BreedResponse?
    var breedImage: BreedImageResponse?
    var buttonText: [String] = []
    var updateViewData: ((BreedQuizData) -> Void)?

    init(fetcher: DataFetcher = NetworkDataFetcher()) {
        self.fetcher = fetcher
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
            updateViewData?(.checkedAnswer(checkedAnswer))
        } else {
            var checkedAnswer = answer
            checkedAnswer.correctAnswer = currentBreed.name
            updateViewData?(.checkedAnswer(checkedAnswer))
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
