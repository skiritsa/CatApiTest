//
//  Int + Extension.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 16.05.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation
extension Int {
    var boolValue: Bool { return self != 0 }
    var isBool: String {String(boolValue)}
}
