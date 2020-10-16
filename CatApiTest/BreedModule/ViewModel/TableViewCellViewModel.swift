//
//  TableViewCellViewModel.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 21.07.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation

class TableViewCellViewModel: TableViewCellViewModelType {

    private let breed: BreedResponse

    var name: String {
        return breed.name
    }
    var origin: String {
        return breed.origin
    }

    init(breed: BreedResponse) {
        self.breed = breed
    }
}
