//
//  ViewModel.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 20.07.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation

class ViewModel: TableViewViewModelType {
    
    let fetcher: DataFetcher
    var allBreed: [BreedResponse] = []
    
    init(fetcher: DataFetcher = NetworkDataFetcher()) {
        self.fetcher = fetcher
    }
    
    func getAllBreed(completion: @escaping () -> ()) {
        fetcher.getBreed { allBreedResponse in
            guard let allBreedResponse = allBreedResponse else { return }
            self.allBreed = allBreedResponse
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func numberOfRows() -> Int {
        return allBreed.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> TableViewCellViewModelType? {
        return TableViewCellViewModel(breed: allBreed[indexPath.row])
    }
    
    func viewModelForSelectedRow(at indexPath: IndexPath) -> DetailViewModel? {
        return DetailViewModel(breed: allBreed[indexPath.row])
    }
}
