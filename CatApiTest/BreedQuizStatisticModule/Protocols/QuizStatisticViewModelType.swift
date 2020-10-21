//
//  QuizStatisticModelType.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 21.10.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation

protocol QuizStatisticViewModelType {
    func getStatistic() -> QuizStatistic?
    func resetStatistic()
}
