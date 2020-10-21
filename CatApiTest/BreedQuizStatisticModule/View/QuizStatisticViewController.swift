//
//  QuizStatisticViewController.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 21.10.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import UIKit

class QuizStatisticViewController: UIViewController {

    let quizStatisticView: QuizStatisticView = {
        let view = QuizStatisticView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var viewModel: QuizStatisticViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configStatisticView()
        quizStatisticView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        getStatistic()
    }

    private func configStatisticView() {
        view.addSubview(quizStatisticView)
        quizStatisticView.fillSuperview()
    }

    private func getStatistic() {
        guard let quizStatistic = viewModel.getStatistic() else { return }
        quizStatisticView.viewModel = quizStatistic
    }
}

extension QuizStatisticViewController: QuizStatisticViewDelegate {

    func resetStatistic() {
        viewModel.resetStatistic()
        self.getStatistic()
    }
}
