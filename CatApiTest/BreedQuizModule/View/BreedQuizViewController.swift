//
//  BreedQuizViewController.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 05.10.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import UIKit

class BreedQuizViewController: UIViewController {

    var viewModel: BreedQuizViewModelType!

    var quizView: QuizView = {
        let view = QuizView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        updateView()
        configBarButton()

        view.backgroundColor = ColorConstant.fourthColor
        title = "Breed Quiz"

        viewModel.getData()
    }

    private func configView() {
        view.addSubview(quizView)
        quizView.fillSuperview()

        quizView.delegate = self
    }

    private func updateView() {
        viewModel.updateViewData = { [weak self] viewData in
            self?.quizView.viewData = viewData
        }
    }

    private func configBarButton() {
        let button = UIBarButtonItem(image: UIImage(named: "emptyStar"), style: .plain, target: self, action: #selector(pushToQuizStatisticVC))
        self.navigationItem.rightBarButtonItem = button

    }

    @objc private func pushToQuizStatisticVC() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
        let quizStatisticVC = QuizStatisticViewController()
        quizStatisticVC.viewModel = QuizStatisticViewModel(context: context)
        self.navigationController?.pushViewController(quizStatisticVC, animated: true)
    }
}

extension BreedQuizViewController: QuizViewDelegate {
    func checkAnswer(answer: BreedQuizData.Answer) {
        viewModel.checkAnswer(answer: answer)
    }

    func reloadQuiz() {
        quizView.viewData = .initial
        viewModel.getData()
    }
}
