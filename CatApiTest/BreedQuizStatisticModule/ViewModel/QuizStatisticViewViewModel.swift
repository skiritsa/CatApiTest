//
//  QuizStatisticViewViewModel.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 21.10.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation

class QuizStatisticViewViewModel {
    let totalPlayed: String
    let winning: String
    let topResult: String
    let lastGame: String

    init(totalPlayed: String, winning: String, topResult: String, lastGame: String) {
        self.totalPlayed = totalPlayed
        self.winning = winning
        self.topResult = topResult
        self.lastGame = lastGame
    }
}
