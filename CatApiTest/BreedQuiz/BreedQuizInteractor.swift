//
//  BreedQuizInteractor.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 22.05.2020.
//  Copyright (c) 2020 Alex Kiritsa. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol BreedQuizBusinessLogic {
    func makeRequest(request: BreedQuiz.Model.Request.RequestType)
}

protocol BreedQuizDataStore {
}

class BreedQuizInteractor: BreedQuizBusinessLogic, BreedQuizDataStore {
    var presenter: BreedQuizPresentationLogic?
    var worker: BreedQuizWorker?
    
    func makeRequest(request: BreedQuiz.Model.Request.RequestType) {
        if worker == nil {
            worker = BreedQuizWorker()
        }
        
        switch request {
        case .getBreed:
            worker?.getBreed(completion: { (breed) in
                guard let breed = breed else { return }
                let currentBreed = self.chooseBreed(breeds: breed)
                self.worker?.getImage(breed: currentBreed, completion: { (imageResponse) in
                    guard let image = imageResponse?.first else { return }
                    self.presenter?.presentData(response: .presentBreed(breeds: breed, image: image))
                })
            })
        }
    }
    
    private func chooseBreed(breeds: [BreedResponse]) -> BreedResponse {
        guard let breed = breeds.randomElement() else { return breeds[0]}
        return breed
    }
}