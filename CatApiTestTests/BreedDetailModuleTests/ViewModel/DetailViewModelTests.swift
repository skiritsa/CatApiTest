//
//  DetailViewModelTests.swift
//  CatApiTestTests
//
//  Created by Alex Kiritsa on 10.09.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import XCTest
@testable import CatApiTest

class DetailViewModelTests: XCTestCase {
    
    var sut: DetailViewModel!
    var breed: BreedResponse!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        breed = BreedResponse(weight: .init(imperial: "10", metric: "10"), id: "abys", name: "Abys", cfaUrl: nil, vetstreetUrl: nil, vcahospitalsUrl: nil, temperament: "Foo", origin: "Bar", countryCodes: "Baz", countryCode: "Foo", description: "Foo", lifeSpan: "Foo", indoor: 1, lap: nil, altNames: "Foo", adaptability: 1, affectionLevel: 1, childFriendly: 1, dogFriendly: 1, energyLevel: 1, grooming: 1, healthIssues: 1, intelligence: 1, sheddingLevel: 1, socialNeeds: 1, strangerFriendly: 1, vocalisation: 1, experimental: 1, hairless: 1, natural: 1, rare: 1, rex: 1, suppressedTail: 1, shortLegs: 1, wikipediaUrl: nil, hypoallergenic: 1, catFriendly: nil, bidability: nil)
        sut = DetailViewModel(breed: breed)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        breed = nil
        try super.tearDownWithError()
    }
    
    func testInitViewModelWithDataFetcherAndBreed() {
        XCTAssertNotNil(sut.breed)
        XCTAssertNotNil(sut.fetcher)
    }
    
    private func configViewModel(completion: @escaping () -> Void) {
        sut.fetcher = MockFetcher()
        let dataExpaction = expectation(description: "Data expectation")
        sut.getData {
            dataExpaction.fulfill()
        }
        
        waitForExpectations(timeout: 10) { _ in
            completion()
        }
    }
    
    func testViewModelGetImageUrl() {
        XCTAssertEqual(self.sut.imageURL, "")
        configViewModel {
            let fetcher = self.sut.fetcher as! MockFetcher
            XCTAssertEqual(self.sut.imageURL, fetcher.imageResponse.first?.url)
        }
    }
    
    func testViewModelGetImageRatio() {
        XCTAssertEqual(self.sut.imageRatio, 0)

        configViewModel {
            let fetcher = self.sut.fetcher as! MockFetcher
            let ratio = CGFloat(fetcher.imageResponse.first!.height) / CGFloat(fetcher.imageResponse.first!.width)
            XCTAssertEqual(self.sut.imageRatio, ratio)
        }
        
    }
    
    func testViewModelConfigPropertyArrayWithBreed() {
        configViewModel {
            XCTAssertEqual((self.sut.allCells.first as! DetailImageViewCellViewModel).imageUrl, self.sut.imageURL)
            XCTAssertEqual((self.sut.allCells[1] as! DetailDescriptionCellViewModel).text, self.sut.breed.description) 
        }
    }
    
}
