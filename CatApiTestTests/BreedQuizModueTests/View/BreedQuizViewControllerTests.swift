//
//  BreedQuizViewControllerTests.swift
//  CatApiTestTests
//
//  Created by Alex Kiritsa on 13.10.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import XCTest
@testable import CatApiTest

class BreedQuizViewControllerTests: XCTestCase {
    
    var sut: BreedQuizViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = BreedQuizViewController()
        sut.viewModel = BreedQuizViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testQuizViewNotNilWhenVCLoad() {
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.quizView)
        XCTAssertTrue(sut.quizView.isDescendant(of: sut.view))
    }
    
    func testSetQuizViewDelegateSelf() {
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.quizView.delegate is BreedQuizViewController)
    }
    
    func testSetTitleVWhenVCLoad() {
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.title, "Breed Quiz")
    }
    
    func testSetBackgroungColorWhenVCLoad() {
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.view.backgroundColor == ColorConstant.fourthColor)
    }
    
    func testCheckAnswerDelegate() {
        sut.viewModel = MockViewModel()
        let answer = BreedQuizData.Answer(answer: "Foo")
        sut.checkAnswer(answer: answer)
        
        XCTAssertTrue((sut.viewModel as! MockViewModel).answerIsChecked)
        XCTAssertNotNil((sut.viewModel as! MockViewModel).checkedAnswer)
        XCTAssertEqual((sut.viewModel as! MockViewModel).checkedAnswer?.answer, answer.answer)
    }
    
    func testReloadQuizDelegate() {
        sut.viewModel = MockViewModel()
        
        sut.reloadQuiz()
        XCTAssertTrue((sut.viewModel as! MockViewModel).dataIsGet)
    }

}

extension BreedQuizViewControllerTests {
    class MockViewModel: BreedQuizViewModel {
        var answerIsChecked: Bool = false
        var checkedAnswer: BreedQuizData.Answer?
        
        var dataIsGet: Bool = false
        
        override func checkAnswer(answer: BreedQuizData.Answer) {
            answerIsChecked = true
            checkedAnswer = answer
        }
        
        override func getData() {
            dataIsGet = true
        }
    }
}
