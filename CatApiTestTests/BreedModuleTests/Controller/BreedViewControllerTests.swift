//
//  BreedViewControllerTests.swift
//  CatApiTestTests
//
//  Created by Alex Kiritsa on 08.09.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import XCTest
import UIKit

@testable import CatApiTest

class BreedViewControllerTests: XCTestCase {
    
    var sut: BreedViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = BreedViewController()
        sut.viewModel = ViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testBreedVCHasTableView() {
        XCTAssertNotNil(sut.tableView)
        XCTAssertTrue(sut.tableView.isDescendant(of: sut.view))
    }
    
    func testBreedVCHasTitle() {
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.title, "All Bread")
    }
    
    func testBreedVCHasActivityIndicator() {
        XCTAssertNotNil(sut.loader)
        XCTAssertTrue(sut.loader.isDescendant(of: sut.view))
    }
    
    func testWhenViewIsLoadedTableViewDelegateIsSet() {
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.tableView.delegate is BreedViewController)
    }
    
    func testWhenViewIsLoadedTableViewDataSourseIsSet() {
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.tableView.dataSource is BreedViewController)
    }
    
    func testTableViewSeparatorStyleIsNone() {
        XCTAssertTrue(sut.tableView.separatorStyle == UITableViewCell.SeparatorStyle.none)
    }
    
    
    func testTableViewReloadedAfterViewModelGetData() {
        let mockTableView = MockTableView()
        sut.tableView = mockTableView
        let mockViewModel = MockViewModel()
        sut.viewModel = mockViewModel
        
        XCTAssertFalse((self.sut.tableView as! MockTableView).isReloaded)
        
        sut.loadViewIfNeeded()
        
        XCTAssertTrue((self.sut.viewModel as! MockViewModel).dataIsGet)
        XCTAssertTrue((self.sut.tableView as! MockTableView).isReloaded)
    }
    
    func testActivityIndicatorStartWhenViewLoaded() {
        XCTAssertFalse(sut.loader.isAnimating)
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.loader.isAnimating)
    }
    
    func testActivityIndicatorStopAndHideWhenViewModelGetData() {
        sut.viewModel = MockViewModel()
        sut.loadViewIfNeeded()
        
        XCTAssertFalse(self.sut.loader.isAnimating)
    }
    
}

extension BreedViewControllerTests {
    class MockTableView: UITableView {
        var isReloaded = false
        var cellIsDequeued = false
        override func reloadData() {
            isReloaded = true
            super.reloadData()
        }
        
//        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
//            cellIsDequeued = true
//            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
//        }
//        
//        static func mockTableView(withDataSourse dataSourse: UITableViewDataSource) -> MockTableView {
//            let mockTableView = MockTableView(frame: CGRect(x: 10, y: 90, width: 368, height: 500), style: .plain)
//            mockTableView.translatesAutoresizingMaskIntoConstraints = false
//            mockTableView.register(BreedCell.self, forCellReuseIdentifier: BreedCell.reuseId)
//            mockTableView.dataSource = dataSourse
//            return mockTableView
//        }
    }
    
    class MockViewModel: ViewModel {
        
        var dataIsGet: Bool = false
        
        override func getAllBreed(completion: @escaping () -> ()) {
            dataIsGet = true
            completion()
        }
    }
}
