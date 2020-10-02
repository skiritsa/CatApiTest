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
    
    func configViewModel(completion: @escaping () -> Void) {
        sut = ViewModel(fetcher: MockFetcher())
        let dataExpectation = expectation(description: "Get data")
        sut.getAllBreed {
            dataExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { _ in
            completion()
        }
    }
    func testViewModelGetAllBreed() {
        configViewModel {
            XCTAssertEqual(self.sut.allBreed.count, (self.sut.fetcher as! MockFetcher).allBreed.count)
        }
    }
    
    func testViewModelGetDataAndReturnNumberOfRows() {
        configViewModel {
            XCTAssertEqual(self.sut.allBreed.count, self.sut.numberOfRows())
        }
    }
    
    func testViewModelCreateCellViewModel() {
        configViewModel {
            let indexPath = IndexPath(row: 0, section: 0)
            let cellViewModel = self.sut.cellViewModel(for: indexPath)
            
            if let cellViewModel = cellViewModel {
                XCTAssertTrue(cellViewModel is TableViewCellViewModel)
            }
        }
    }
    
    func testViewModelCreateDetailViewModel() {
        configViewModel { 
            let indexPath = IndexPath(row: 0, section: 0)
            let cellViewModel = self.sut.viewModelForSelectedRow(at: indexPath)
            
            if let cellViewModel = cellViewModel {
                XCTAssertTrue(cellViewModel is DetailViewModel)
            }
        }
    }
}

class MockFetcher: DataFetcher {
    
    var allBreed: [BreedResponse] = []
    var imageResponse: [BreedImageResponse] = []
    let networkFetcher = NetworkDataFetcher()
    
    func getBreed(response: @escaping ([BreedResponse]?) -> Void) {
        networkFetcher.getBreed { breedResponse in
            if let breedResponse = breedResponse {
                self.allBreed = breedResponse
                response(breedResponse)
            }
        }
    }
    
    func getImageUrl(_ forBreed: BreedResponse?, response: @escaping ([BreedImageResponse]?) -> Void) {
        
        networkFetcher.getBreed { [weak self] (breed) in
            self?.networkFetcher.getImageUrl(breed?.first) { imageResponse in
                if let imageResponse = imageResponse {
                    self?.imageResponse = imageResponse
                    response(imageResponse)
                }
            }
        }
    }
    
    
}
