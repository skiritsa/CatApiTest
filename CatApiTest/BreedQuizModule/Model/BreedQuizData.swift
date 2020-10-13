//
//  BreedQuizData.swift
//  CatApiTestTests
//
//  Created by Alex Kiritsa on 03.10.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation

enum BreedQuizData {
    
    case initial
    case loading(Data)
    case checkedAnswer(Answer)
    
    struct Data {
        let imageUrl: String
        let buttonTextArray: [String]
    }
    
    struct Answer {
        let answer: String
        var isCorrect: Bool = false
        var correctAnswer: String? = nil
    }
}
