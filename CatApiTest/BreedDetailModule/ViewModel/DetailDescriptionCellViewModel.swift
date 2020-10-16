//
//  DetailDescriptionCellViewModel.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 09.08.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation

class DetailDescriptionCellViewModel: DetailCellViewModelType {

    var type: DetailViewModelItemType {
        return .descriptionBreedCell
    }

    let title: String
    let text: String

    init(title: String, text: String) {
        self.title = title
        self.text = text
    }
}
