//
//  DetailViewModel.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 22.07.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation
import UIKit

class DetailViewModel: DetailViewModelType {
    
    var breed: BreedResponse
    var fetcher: DataFetcher
    
    var allCells = [DetailCellViewModelType]()
    
    var imageRatio: CGFloat = 0
    
    var imageURL: String = ""
    
    func numberOfRows() -> Int {
        return allCells.count
    }
    
    private func configData(breed: BreedResponse) {
        
        let breedPhoto = DetailImageViewCellViewModel(imageUrl: imageURL)
        let description = DetailDescriptionCellViewModel(title: "DESCRIPTION", text: breed.description)
        let lifeSpan = DetailTextCellViewModel(title: "LIFESPAN", text: breed.lifeSpan)
        let weigh = DetailTextCellViewModel(title: "WEIGHT", text: breed.weight.metric)
        let temperament = DetailTextCellViewModel(title: "TEMPERAMENT", text: breed.temperament)
        let origin = DetailTextCellViewModel(title: "ORIGIN", text: breed.origin)
        let adaptability = DetailRatingCellViewModel(title: "ADAPTABILITY", rating: breed.adaptability)
        let childFriendly = DetailRatingCellViewModel(title: "CHILD FRIENDLY", rating: breed.childFriendly)
        let dogFriendly = DetailRatingCellViewModel(title: "DOG FRIENDLY", rating: breed.dogFriendly)
        let energyLevel = DetailRatingCellViewModel(title: "ENERGY LEVEL", rating: breed.energyLevel)
        let grooming = DetailRatingCellViewModel(title: "GROOMING", rating: breed.grooming)
        let healthIssues = DetailRatingCellViewModel(title: "HEALTH ISSUES", rating: breed.healthIssues)
        let sheddingLevel = DetailRatingCellViewModel(title: "SHEDDING LEVEL", rating: breed.sheddingLevel)
        let socialNeeds = DetailRatingCellViewModel(title: "SOCIAL NEEDS", rating: breed.socialNeeds)
        let experimental = DetailTextCellViewModel(title: "EXPERIMENTAL", text: breed.experimental.isBool)
        let natural = DetailTextCellViewModel(title: "NATURAL", text: breed.natural.isBool)
        let rare = DetailTextCellViewModel(title: "RARE", text: breed.rare.isBool)
        let hypoallergenic = DetailTextCellViewModel(title: "HYPOALLERGENIC", text: breed.hypoallergenic.isBool)
        
        allCells = [breedPhoto, description, lifeSpan, weigh, temperament, origin,
                    adaptability, childFriendly, dogFriendly, energyLevel, grooming,
                    healthIssues, sheddingLevel, socialNeeds, experimental, natural,
                    rare, hypoallergenic]
        
    }
    
    func getData(completion: @escaping () -> ()) {
        fetcher.getImageUrl(breed) { imageResponse in
            
            guard let imageResponse = imageResponse?.first else { return }
            
            self.imageURL = imageResponse.url
            self.imageRatio = CGFloat(imageResponse.height) / CGFloat(imageResponse.width)
            self.configData(breed: self.breed)
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    init(breed: BreedResponse, fetcher: DataFetcher = NetworkDataFetcher()) {
        self.breed = breed
        self.fetcher = fetcher
    }
}
