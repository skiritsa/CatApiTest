//
//  DetailDescriptionViewCelTests.swift
//  CatApiTestTests
//
//  Created by Alex Kiritsa on 02.10.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import XCTest
@testable import CatApiTest

class DetailDescriptionViewCelTests: XCTestCase {

    var sut: DetailDescriptionViewCell!
    let viewModel = DetailDescriptionCellViewModel(title: "Foo", text: "Bar")
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = DetailDescriptionViewCell(style: .default, reuseIdentifier: DetailDescriptionViewCell.reuseId)
        sut.viewModel = viewModel
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testInitCell() {
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertNotNil(sut.textView)
    }
    
    func testSelectionStyleIsNoneAfterInit() {
        XCTAssertTrue(sut.selectionStyle == UITableViewCell.SelectionStyle.none)
    }
    
    func testBackgroundColorIsClearAfterInit() {
        XCTAssertTrue(sut.backgroundColor == UIColor.clear)
    }
    
    func testSetsTextInLabelWhenViewModelSet() {
        XCTAssertEqual(sut.titleLabel.text, viewModel.title)
        XCTAssertEqual(sut.textView.text, viewModel.text)
    }

}
