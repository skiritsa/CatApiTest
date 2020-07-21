//
//  TableViewCellViewModelType.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 20.07.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation

protocol TableViewCellViewModelType: class {
    var name: String { get }
    var origin: String { get }
}
