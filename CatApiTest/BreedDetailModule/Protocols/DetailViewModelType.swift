//
//  DetailViewModelType.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 22.07.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation
import UIKit

protocol DetailViewModelType {
    var allCells: [DetailCellViewModelType] { get }
    var imageRatio: CGFloat { get }
    func numberOfRows() -> Int
    func getData(completion: @escaping () -> Void)
}
