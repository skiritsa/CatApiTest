//
//  TableViewCellViewModelTests.swift
//  CatApiTestTests
//
//  Created by Alex Kiritsa on 08.09.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import XCTest
@testable import CatApiTest

class TableViewCellViewModelTests: XCTestCase {

    var sut: TableViewCellViewModel!
    var breed: BreedResponse!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        breed = BreedResponse(weight: .init(imperial: "10", metric: "10"), id: "abys", name: "Abys", cfaUrl: nil, vetstreetUrl: nil, vcahospitalsUrl: nil, temperament: "Foo", origin: "Bar", countryCodes: "Baz", countryCode: "Foo", description: "Foo", lifeSpan: "Foo", indoor: 1, lap: nil, altNames: "Foo", adaptability: 1, affectionLevel: 1, childFriendly: 1, dogFriendly: 1, energyLevel: 1, grooming: 1, healthIssues: 1, intelligence: 1, sheddingLevel: 1, socialNeeds: 1, strangerFriendly: 1, vocalisation: 1, experimental: 1, hairless: 1, natural: 1, rare: 1, rex: 1, suppressedTail: 1, shortLegs: 1, wikipediaUrl: nil, hypoallergenic: 1, catFriendly: nil, bidability: nil)
        
        sut = TableViewCellViewModel(breed: breed)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testInitViewModelWithBreed() {
        XCTAssertEqual(sut.name, breed.name)
        XCTAssertEqual(sut.origin, breed.origin)
    }

}
