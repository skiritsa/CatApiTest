//
//  QuizStatisticView + Extension.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 21.10.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import UIKit

extension QuizStatisticView {

    func makeTotalPlayLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = "Total played: "
        label.adjustsFontSizeToFitWidth = true

        addSubview(label)
        label.topAnchor.constraint(equalTo: topAnchor, constant: 80).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true

        return label
    }

    func makeWinningLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = "Winning: "
        label.adjustsFontSizeToFitWidth = true

        addSubview(label)
        label.topAnchor.constraint(equalTo: totalPlayLabel.bottomAnchor, constant: 20).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true

        return label
    }

    func makeLastGameLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = "Last game: "
        label.adjustsFontSizeToFitWidth = true

        addSubview(label)
        label.topAnchor.constraint(equalTo: winningLabel.bottomAnchor, constant: 20).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true

        return label
    }

    func makeResetButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray
        button.setTitle("Reset statistic", for: .normal)

        button.addTarget(self, action: #selector(resetStatistic), for: .touchUpInside)

        addSubview(button)
        button.topAnchor.constraint(equalTo: lastGameLabel.bottomAnchor, constant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 250).isActive = true
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        return button
    }
}
