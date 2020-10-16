//
//  DetailImageViewCellViewModel.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 12.08.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation

class DetailImageViewCellViewModel: DetailCellViewModelType {

    var type: DetailViewModelItemType {
        return .imageViewCell
    }

    var imageUrl: String

    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
}
