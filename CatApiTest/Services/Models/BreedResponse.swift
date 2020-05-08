//
//  BreedResponse.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 04.05.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation

struct BreedResponse: Codable {
    let weight: Weight
    let id: String
    let name: String
    let cfaUrl: String?
    let vetstreetUrl: String?
    let vcahospitalsUrl: String?
    let temperament: String
    let origin: String
    let countryCodes: String
    let countryCode: String
    let description: String
    let lifeSpan: String
    let indoor: Int
    let lap: Int?
    let altNames: String?
    let adaptability: Int
    let affectionLevel: Int
    let childFriendly: Int
    let dogFriendly: Int
    let energyLevel: Int
    let grooming: Int
    let healthIssues: Int
    let intelligence: Int
    let sheddingLevel: Int
    let socialNeeds: Int
    let strangerFriendly: Int
    let vocalisation: Int
    let experimental: Int
    let hairless: Int
    let natural: Int
    let rare: Int
    let rex: Int
    let suppressedTail: Int
    let shortLegs: Int
    let wikipediaUrl: String?
    let hypoallergenic: Int
    let catFriendly: Int?
    let bidability: Int?

}

// MARK: - Weight
struct Weight: Codable {
    let imperial: String
    let metric: String
}
