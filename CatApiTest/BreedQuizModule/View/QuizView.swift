//
//  QuizView.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 05.10.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import UIKit

protocol QuizViewDelegate: class {
    func checkAnswer(answer: BreedQuizData.Answer)
    func reloadQuiz()
}

class QuizView: UIView {

    weak var delegate: QuizViewDelegate!

    var viewData: BreedQuizData = .initial {
        didSet {
            layoutSubviews()
        }
    }

    lazy var titleLabel = makeTitleLabel()
    lazy var imageView = makeImageView()
    lazy var stackView = makeStackView()
    lazy var loader = makeActivityIndicator()
    lazy var reloadQuizButton = makeReloadQuizButton()

    var buttonArray: [UIButton] = []

    override func layoutSubviews() {
        switch viewData {
        case .initial:
            prepareForReload()
        case .loading(let quizData):
            displayData(data: quizData)
        case .checkedAnswer(let answer):
            configButtonAfterAnswer(answer: answer)
        }
    }

    private func prepareForReload() {
        for button in buttonArray {
            button.isEnabled = true
            button.backgroundColor = ColorConstant.firstColor
        }
        imageView.image = nil

        imageView.isHidden = true
        titleLabel.isHidden = true
        stackView.isHidden = true
        reloadQuizButton.isHidden = true

        loader.startAnimating()
    }

    private func displayData(data: BreedQuizData.Data) {
        imageView.set(imageURL: data.imageUrl)
        setTitleForButtonArray(array: data.buttonTextArray)

        loader.stopAnimating()

        imageView.isHidden = false
        titleLabel.isHidden = false
        stackView.isHidden = false
    }

    func setTitleForButtonArray(array: [String]) {
        for button in buttonArray {
            button.setTitle(array[button.tag], for: .normal)
        }
    }

    func configButtonAfterAnswer(answer: BreedQuizData.Answer) {
        for button in buttonArray {
            if button.titleLabel?.text == answer.answer && answer.isCorrect || button.titleLabel?.text == answer.correctAnswer {
                button.backgroundColor = ColorConstant.thirdColor
            } else if button.titleLabel?.text == answer.answer && answer.isCorrect == false {
                button.backgroundColor = ColorConstant.badAnswerColor
            } else {
                button.backgroundColor = ColorConstant.otherAnswerColor
            }
            button.isEnabled = false
        }
        reloadQuizButton.isHidden = false
    }

    @objc func checkResponse(_ sender: UIButton) {
        if let text = sender.titleLabel?.text {
            let answer = BreedQuizData.Answer(answer: text)
            delegate.checkAnswer(answer: answer)
        }
    }

    @objc func reloadQuiz() {
        delegate.reloadQuiz()
    }
}
