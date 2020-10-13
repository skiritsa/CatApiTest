//
//  BreedQuizViewModelType.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 03.10.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation

protocol BreedQuizViewModelType {
    var updateViewData: ((BreedQuizData)->())? { get set }
    func getData()
    func checkAnswer(answer: BreedQuizData.Answer)
}
