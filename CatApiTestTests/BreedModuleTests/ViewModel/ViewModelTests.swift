//
//  ViewModelTests.swift
//  CatApiTestTests
//
//  Created by Alex Kiritsa on 08.09.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import XCTest
@testable import CatApiTest
class ViewModelTests: XCTestCase {
    
    var sut: ViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }


    func testInitViewModelWithNetworkDataFetcher() {
        XCTAssertNotNil(sut.fetcher)
    }
    
    func configViewModel() {
        sut = ViewModel(fetcher: MockFetcher())
        sut.getAllBreed {}
    }
    func testViewModelGetAllBreed() {
        configViewModel()
        XCTAssertTrue(self.sut.allBreed.count == 2)
    }
    
    func testViewModelGetDataAndReturnNumberOfRows() {
        configViewModel()
        XCTAssertEqual(sut.allBreed.count, sut.numberOfRows())
    }
    
    func testViewModelCreateCellViewModel() {
        configViewModel()
        let indexPath = IndexPath(row: 0, section: 0)
        let cellViewModel = sut.cellViewModel(for: indexPath)
        
        if let cellViewModel = cellViewModel {
            XCTAssertTrue(cellViewModel is TableViewCellViewModel)
        }
    }
    
    func testViewModelCreateDetailViewModel() {
        configViewModel()
        let indexPath = IndexPath(row: 0, section: 0)
        let cellViewModel = sut.viewModelForSelectedRow(at: indexPath)
        
        if let cellViewModel = cellViewModel {
            XCTAssertTrue(cellViewModel is DetailViewModel)
        }
    }
}

class MockFetcher: DataFetcher {
    
    var allBreed: [BreedResponse] = []
    
    func getBreed(response: @escaping ([BreedResponse]?) -> Void) {
        let breedItem = BreedResponse(weight: .init(imperial: "10", metric: "10"), id: "abys", name: "Abys", cfaUrl: nil, vetstreetUrl: nil, vcahospitalsUrl: nil, temperament: "Foo", origin: "Bar", countryCodes: "Baz", countryCode: "Foo", description: "Foo", lifeSpan: "Foo", indoor: 1, lap: nil, altNames: "Foo", adaptability: 1, affectionLevel: 1, childFriendly: 1, dogFriendly: 1, energyLevel: 1, grooming: 1, healthIssues: 1, intelligence: 1, sheddingLevel: 1, socialNeeds: 1, strangerFriendly: 1, vocalisation: 1, experimental: 1, hairless: 1, natural: 1, rare: 1, rex: 1, suppressedTail: 1, shortLegs: 1, wikipediaUrl: nil, hypoallergenic: 1, catFriendly: nil, bidability: nil)
        
        allBreed.append(breedItem)
        allBreed.append(breedItem)

        response(allBreed)
    }
    
    func getImageUrl(_ forBreed: BreedResponse?, response: @escaping ([BreedImageResponse]?) -> Void) {
        response(nil)
    }
    
    
}
