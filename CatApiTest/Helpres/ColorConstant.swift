//
//  ColorConstant.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 22.05.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import Foundation
import UIKit

struct ColorConstant {
    static let firstColor = UIColor(hex: "#ad6989")
    static let secondColor = UIColor(hex: "#abf0e9")
    static let thirdColor = UIColor(hex: "#63b7af")
    static let fourthColor = UIColor(hex: "#d4f3ef")
    static let badAnswerColor = UIColor(hex: "9a1f40")
    static let otherAnswerColor = UIColor(hex: "3f3f44")
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hexString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format: "#%06x", rgb)
    }
}
