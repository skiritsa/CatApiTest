//
//  BreedImageResponse.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 14.05.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation

struct BreedImageResponse: Codable {
    let breeds: [BreedResponse]
    let id: String
    let url: String
    let width: Int
    let height: Int
}
