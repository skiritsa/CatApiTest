//
//  TableViewViewModelType.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 20.07.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation

protocol TableViewViewModelType {
    
    var allBreed: [BreedResponse] { get set }
    
    func getAllBreed(completion: @escaping () -> ())
    func numberOfRows() -> Int
    func cellViewModel(for indexPath: IndexPath) -> TableViewCellViewModelType?
    func selectRow(at indexPath: IndexPath)
}

