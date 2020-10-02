//
//  DetailImageViewCellTests.swift
//  CatApiTestTests
//
//  Created by Alex Kiritsa on 02.10.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import XCTest
@testable import CatApiTest

class DetailImageViewCellTests: XCTestCase {

    var sut: DetailImageViewCell!
    let viewModel = DetailImageViewCellViewModel(imageUrl: "Foo")
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = DetailImageViewCell(style: .default, reuseIdentifier: DetailImageViewCell.reuseId)
        sut.viewModel = viewModel
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testInitCell() {
        XCTAssertNotNil(sut.catImageView)
    }
    
    func testBackgroundColorIsClearAfterInit() {
        XCTAssertTrue(sut.backgroundColor == UIColor.clear)
    }
    
    func testSetsUrlWhenViewModelSet() {
        sut.catImageView = MockImageView()
        sut.viewModel = viewModel
        XCTAssertEqual((sut.catImageView as! MockImageView).url, viewModel.imageUrl)
    }

}

extension DetailImageViewCellTests {
    class MockImageView: WebImageView {
        var url: String?
        
        override func set(imageURL: String?) {
            url = imageURL
            super.set(imageURL: imageURL)
        }
    }
}
