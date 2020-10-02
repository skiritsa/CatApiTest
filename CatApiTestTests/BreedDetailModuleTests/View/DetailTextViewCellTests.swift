//
//  DetailTextViewCellTests.swift
//  CatApiTestTests
//
//  Created by Alex Kiritsa on 02.10.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import XCTest
@testable import CatApiTest

class DetailTextViewCellTests: XCTestCase {
    
    var sut: DetailTextViewCell!
    let viewModel = DetailTextCellViewModel(title: "Foo", text: "Bar")
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = DetailTextViewCell(style: .default, reuseIdentifier: DetailTextViewCell.reuseId)
        sut.viewModel = viewModel
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testInitCell() {
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertNotNil(sut.breedPropertyLabel)
    }
    
    func testSelectionStyleIsNoneAfterInit() {
        XCTAssertTrue(sut.selectionStyle == UITableViewCell.SelectionStyle.none)
    }
    
    func testBackgroundColorIsClearAfterInit() {
        XCTAssertTrue(sut.backgroundColor == UIColor.clear)
    }

    func testSetsTextInLabelWhenViewModelSet() {
        XCTAssertEqual(sut.titleLabel.text, viewModel.title.uppercased())
        XCTAssertEqual(sut.breedPropertyLabel.text, viewModel.text.uppercased())
    }
}
