//
//  QuizViewTests.swift
//  CatApiTestTests
//
//  Created by Alex Kiritsa on 12.10.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import XCTest
@testable import CatApiTest

class QuizViewTests: XCTestCase {
    
    var sut: QuizView!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = QuizView()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testTitleLabelNotNilAfterInit() {
        XCTAssertNotNil(sut.titleLabel)
    }
    
    func testTitleLabelConfigAfterInit() {
        let titleText = "What breed is the cat in the picture?"
        
        XCTAssertEqual(sut.titleLabel.text, titleText)
        XCTAssertTrue(sut.titleLabel.numberOfLines == 1)
        XCTAssertTrue(sut.titleLabel.textAlignment == .center)
        XCTAssertTrue(sut.titleLabel.font == .systemFont(ofSize: 22, weight: .bold))
        XCTAssertTrue(sut.titleLabel.adjustsFontSizeToFitWidth)
        XCTAssertTrue(sut.titleLabel.isHidden)
    }
    
    func testImageViewNotNilAfterInit() {
        XCTAssertNotNil(sut.imageView)
    }

    func testImageViewContentModeIsScaleAspectFit() {
        XCTAssertTrue(sut.imageView.contentMode == .scaleAspectFit)
    }
    
    func testStackViewNotNilAfterInit() {
        XCTAssertNotNil(sut.stackView)
    }
    
    func testStackViewConfigAfterInit() {
        XCTAssertTrue(sut.stackView.axis == .vertical)
        XCTAssertTrue(sut.stackView.distribution == .fillProportionally)
        XCTAssertTrue(sut.stackView.alignment == .fill)
        XCTAssertTrue(sut.stackView.spacing == 10)
        XCTAssertTrue(sut.stackView.isHidden)
        
        XCTAssertTrue(sut.stackView.arrangedSubviews.count == 4)
    }
    
    func testButtonInStackViewConfigAfterInit() {
        _ = sut.stackView.spacing
        guard let button = sut.buttonArray.first else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(button.backgroundColor == ColorConstant.firstColor)
        XCTAssertTrue(button.layer.cornerRadius == 10)
        XCTAssertTrue(button.clipsToBounds)
        
        guard let action = button.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }
        XCTAssertTrue(action.contains("checkResponse:"))
    }
    
    func testActivityIndicatorNotNilAfterInit() {
        XCTAssertNotNil(sut.loader)
    }
    
    func testActivityIndicatorHideWenSttopped() {
        XCTAssertTrue(sut.loader.hidesWhenStopped)
    }
    
    func testReloadButtonNotNilAfterInit() {
        XCTAssertNotNil(sut.reloadQuizButton)
    }
    
    func testReloadButtonConfigAfterInit() {
        XCTAssertTrue(sut.reloadQuizButton.isHidden)
        XCTAssertTrue(sut.reloadQuizButton.imageView?.image == UIImage(named: "reload"))
        
        guard let action = sut.reloadQuizButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }
        XCTAssertTrue(action.contains("reloadQuiz"))
    }
    
    func testPrepareForReloadWhenViewDataIsInitial() {
        _ = sut.stackView.spacing
        sut.viewData = .initial
        
        XCTAssertNil(sut.imageView.image)
        XCTAssertTrue(sut.imageView.isHidden)
        XCTAssertTrue(sut.titleLabel.isHidden)
        XCTAssertTrue(sut.stackView.isHidden)
        XCTAssertTrue(sut.reloadQuizButton.isHidden)
        XCTAssertTrue(sut.loader.isAnimating)
        
        _ = sut.buttonArray.map {
            XCTAssertTrue($0.isEnabled)
            XCTAssertTrue($0.backgroundColor == ColorConstant.firstColor)
        }
    }
    
    func testDisplayDataWhenViewDataIsLoading() {
        sut.imageView = MockImageView()
        sut.addSubview(sut.imageView)
        _ = sut.stackView.spacing
        
        let quizData = BreedQuizData.Data(imageUrl: "URL", buttonTextArray: ["Foo", "Bar", "Baz", "Fooo"])
        
        sut.viewData = .loading(quizData)
        
        XCTAssertEqual((sut.imageView as! MockImageView).url, quizData.imageUrl)
        
        XCTAssertFalse(sut.loader.isAnimating)
        
        XCTAssertFalse(sut.imageView.isHidden)
        XCTAssertFalse(sut.titleLabel.isHidden)
        XCTAssertFalse(sut.stackView.isHidden)
        
        for button in sut.buttonArray {
            XCTAssertEqual(button.titleLabel?.text, quizData.buttonTextArray[button.tag])
        }
    }
    
    func testDisplayDataWhenViewDataIsCheckAnswer() {
        _ = sut.stackView.spacing
        
        let quizData = BreedQuizData.Data(imageUrl: "URL", buttonTextArray: ["Foo", "Bar", "Baz", "Fooo"])
        
        sut.viewData = .loading(quizData)

        let answer = BreedQuizData.Answer(answer: "Foo", isCorrect: false, correctAnswer: "Bar")
        sut.viewData = .checkedAnswer(answer)
        
        XCTAssertTrue(sut.buttonArray[0].backgroundColor == ColorConstant.badAnswerColor)
        XCTAssertFalse(sut.buttonArray[0].isEnabled)
        XCTAssertTrue(sut.buttonArray[1].backgroundColor == ColorConstant.thirdColor)
        XCTAssertTrue(sut.buttonArray[2].backgroundColor == ColorConstant.otherAnswerColor)
        XCTAssertTrue(sut.buttonArray[3].backgroundColor == ColorConstant.otherAnswerColor)
    }
    
    func testCheckRespponseAction() {
        let delegate = MockQuizViewDelegate()
        sut.delegate = delegate.self
        
        let button = UIButton()
        button.titleLabel?.text = "Foo"
        
        sut.checkResponse(button)
        
        XCTAssertTrue(delegate.isChecked)
    }
    
    func testReloadQuizAction() {
        let delegate = MockQuizViewDelegate()
        sut.delegate = delegate.self
        
        sut.reloadQuiz()
        
        XCTAssertTrue(delegate.isReload)
    }
}

extension QuizViewTests {
    class MockImageView: WebImageView {
        var url: String?
        
        override func set(imageURL: String?) {
            url = imageURL
        }
    }
    
    class MockQuizViewDelegate: QuizViewDelegate {
        var isChecked: Bool = false
        var isReload: Bool = false
        func checkAnswer(answer: BreedQuizData.Answer) {
            isChecked = true
        }
        
        func reloadQuiz() {
            isReload = true
        }
    }
}
