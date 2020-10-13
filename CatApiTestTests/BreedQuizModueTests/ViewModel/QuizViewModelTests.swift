//
//  QuizViewModelTests.swift
//  CatApiTestTests
//
//  Created by Alex Kiritsa on 03.10.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import XCTest
@testable import CatApiTest

class QuizViewModelTests: XCTestCase {
    
    var sut: BreedQuizViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = BreedQuizViewModel()
    }

    override func tearDownWithError() throws {
        
        try super.tearDownWithError()
    }

    
    func testInitViewModelWitFetcher() {
        XCTAssertNotNil(sut.fetcher)
    }
    
    func getDataWithDelay(completion: @escaping () -> Void) {
        sut.getData()
        
        let dataExpectation = expectation(description: "Get breed and image response")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            dataExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 6) { _ in
            completion()
        }
    }
    
    func testViewModelGetDataForQuiz() {
        getDataWithDelay {
            XCTAssertNotNil(self.sut.currentBreed)
            XCTAssertNotNil(self.sut.breedImage)
        }
    }
    
    func testViewModelSendLoadingToDelegateAferGetData() {
        
        var data: BreedQuizData?
        
        sut.updateViewData = { quizData in
            data = quizData
        }
        
        getDataWithDelay {
            XCTAssertNotNil(data)
        }
    }
    
    func testViewModelCheckedAnswer() {
        
        var switchData: BreedQuizData.Answer!
        
        sut.updateViewData = { quizData in
            switch quizData {
            case .initial:
                return
            case .loading(_):
                return
            case .checkedAnswer(let data):
                switchData = data
            }
        }
        
        let breed = BreedResponse(weight: Weight(imperial: "Bar", metric: "Bar"), id: "Foo", name: "Bar", cfaUrl: nil, vetstreetUrl: nil, vcahospitalsUrl: nil, temperament: "Baz", origin: "Baz", countryCodes: "Baz", countryCode: "Baz", description: "Baz", lifeSpan: "Baz", indoor: 0, lap: nil, altNames: nil, adaptability: 0, affectionLevel: 0, childFriendly: 0, dogFriendly: 0, energyLevel: 0, grooming: 0, healthIssues: 0, intelligence: 0, sheddingLevel: 0, socialNeeds: 0, strangerFriendly: 0, vocalisation: 0, experimental: 0, hairless: 0, natural: 0, rare: 0, rex: 0, suppressedTail: 0, shortLegs: 0, wikipediaUrl: nil, hypoallergenic: 0, catFriendly: 0, bidability: 0)
        
        sut.currentBreed = breed
        let correctAnswer = BreedQuizData.Answer(answer: breed.name)
        
        sut.checkAnswer(answer: correctAnswer)
        
        XCTAssertTrue(switchData.answer == correctAnswer.answer)
        XCTAssertTrue(switchData.isCorrect)
        XCTAssertEqual(switchData.answer, switchData.correctAnswer)
        
        let wrongAnswer = BreedQuizData.Answer(answer: breed.id)
        sut.checkAnswer(answer: wrongAnswer)
        
        XCTAssertTrue(switchData.answer == wrongAnswer.answer)
        XCTAssertFalse(switchData.isCorrect)
    }
}
