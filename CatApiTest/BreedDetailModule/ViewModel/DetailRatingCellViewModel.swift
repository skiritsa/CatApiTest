//
//  DetailRatingCellViewModel.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 11.08.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation

class DetailRatingCellViewModel: DetailCellViewModelType {
    
    var type: DetailViewModelItemType {
        return .ratingPropertyCell
    }
    
    let title: String
    let rating: Int
    
    init(title: String, rating: Int) {
        self.title = title
        self.rating = rating
    }
}
