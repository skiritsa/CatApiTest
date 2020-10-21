//
//  QuizStatisticView.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 21.10.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import UIKit

protocol QuizStatisticViewDelegate: class {
    func resetStatistic()
}

class QuizStatisticView: UIView {

    weak var delegate: QuizStatisticViewDelegate!

    lazy var totalPlayLabel = makeTotalPlayLabel()
    lazy var winningLabel = makeWinningLabel()
    lazy var lastGameLabel = makeLastGameLabel()
    lazy var resetButton = makeResetButton()

    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()

    var viewModel: QuizStatistic! {
        didSet {
            totalPlayLabel.text = "Total played: " + String(viewModel.totalPlayed)
            winningLabel.text = "Winning: " + String(viewModel.winning)
            if let lastGame = viewModel.lastGame {
            lastGameLabel.text = "Last game: " + dateFormatter.string(from: lastGame)
            } else {
                lastGameLabel.text = "Last game: "
            }
            _ = resetButton.isHidden
        }
    }

    @objc func resetStatistic() {
        delegate.resetStatistic()
    }
}
