//
//  BreedCellTests.swift
//  CatApiTestTests
//
//  Created by Alex Kiritsa on 04.09.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import XCTest
@testable import CatApiTest

class BreedCellTests: XCTestCase {
    
    var sut: BreedCell!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = BreedCell(style: .default, reuseIdentifier: BreedCell.reuseId)
    }

    override func tearDownWithError() throws {
        
        super.tearDown()
    }

    func testCellHasCardView() {
        XCTAssertNotNil(sut.cardView)
        XCTAssertFalse(sut.cardView.translatesAutoresizingMaskIntoConstraints)
    }
    
    func testCellHasBreedNameLabel() {
        XCTAssertNotNil(sut.breedNameLabel)
        XCTAssertFalse(sut.breedNameLabel.translatesAutoresizingMaskIntoConstraints)
    }
    
    func testCellHasBreedNameLabelInCardContentView() {
        XCTAssertTrue(sut.breedNameLabel.isDescendant(of: sut.cardView))
    }
    
    func testCellHasCatImageView() {
        XCTAssertNotNil(sut.catImageView)
        XCTAssertFalse(sut.catImageView.translatesAutoresizingMaskIntoConstraints)
    }
    
    func testCellHasCatImageViewInCardContentView() {
        XCTAssertTrue(sut.catImageView.isDescendant(of: sut.cardView))
    }
    
    func testCellOriginNameLabel() {
        XCTAssertNotNil(sut.originNameLabel)
        XCTAssertFalse(sut.originNameLabel.translatesAutoresizingMaskIntoConstraints)
    }
    
    func testCellHasOriginNameLabelInCardContentView() {
        XCTAssertTrue(sut.originNameLabel.isDescendant(of: sut.cardView))
    }
    
    func testCellOriginImageView() {
        XCTAssertNotNil(sut.originImageView)
        XCTAssertFalse(sut.originImageView.translatesAutoresizingMaskIntoConstraints)
    }
    
    func testCellHasOriginImageViewInCardContentView() {
        XCTAssertTrue(sut.originImageView.isDescendant(of: sut.cardView))
    }
        
    func testCellHasDataWhenViewModelSets() {
        let breed = BreedResponse(weight: .init(imperial: "10", metric: "10"), id: "abys", name: "Abys", cfaUrl: nil, vetstreetUrl: nil, vcahospitalsUrl: nil, temperament: "Foo", origin: "Bar", countryCodes: "Baz", countryCode: "Foo", description: "Foo", lifeSpan: "Foo", indoor: 1, lap: nil, altNames: "Foo", adaptability: 1, affectionLevel: 1, childFriendly: 1, dogFriendly: 1, energyLevel: 1, grooming: 1, healthIssues: 1, intelligence: 1, sheddingLevel: 1, socialNeeds: 1, strangerFriendly: 1, vocalisation: 1, experimental: 1, hairless: 1, natural: 1, rare: 1, rex: 1, suppressedTail: 1, shortLegs: 1, wikipediaUrl: nil, hypoallergenic: 1, catFriendly: nil, bidability: nil)
        let viewModel = TableViewCellViewModel(breed: breed)
        
        sut.viewModel = viewModel
        
        XCTAssertEqual(sut.breedNameLabel.text, breed.name)
        XCTAssertEqual(sut.originNameLabel.text, breed.origin)
    }
    
    func testImageViewInCellHasImage() {
        XCTAssertNotNil(sut.catImageView.image)
        XCTAssertNotNil(sut.originImageView.image)
    }
    
    func testCellBackgroundColorIsClear() {
        XCTAssertTrue(sut.backgroundColor == UIColor.clear)
    }
    
    func testCellSelectionStyleIsNone() {
        XCTAssertTrue(sut.selectionStyle == UITableViewCell.SelectionStyle.none)
    }
}
