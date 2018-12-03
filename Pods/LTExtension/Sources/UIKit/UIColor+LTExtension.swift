//
//  UIColor+LTExtension.swift
//  LTExtensionDemo
//
//  Created by TopSky on 2018/3/8.
//  Copyright © 2018年 TopSky. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {

    class func color(_ R: CGFloat, _ G: CGFloat, _ B: CGFloat, _ A: CGFloat = 1) -> UIColor {
        return UIColor(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: A)
    }

    class func color(_ H: UInt, _ A: CGFloat = 1) -> UIColor {
        let R = CGFloat((H & 0xFF0000) >> 16)
        let G = CGFloat((H & 0xFF00) >> 8)
        let B = CGFloat(H & 0x0000FF)
        return color(R, G, B, A)
    }


    class func color(_ H: String, _ A: CGFloat = 1) -> UIColor {

        var h = H.trimmingCharacters(in: .whitespacesAndNewlines)
        guard h.count >= 6 else {
            return UIColor.black
        }

        if h.hasPrefix("0x") || h.hasPrefix("0X") {
            let index = h.index(h.startIndex, offsetBy: 2)
            h = String(h.suffix(from: index))
        }

        if h.hasPrefix("#") {
            let index = h.index(h.startIndex, offsetBy: 1)
            h = String(h.suffix(from: index))
        }

        guard h.count == 6 else {
            return UIColor.black
        }

        let rf = h.startIndex
        let rt = h.index(h.startIndex, offsetBy: 2)
        let rRange = rf..<rt
        let r = String(h[rRange])

        let gf = h.index(h.startIndex, offsetBy: 2)
        let gt = h.index(h.startIndex, offsetBy: 4)
        let gRange = gf..<gt
        let g = String(h[gRange])

        let bf = h.index(h.startIndex, offsetBy: 4)
        let bt = h.index(h.startIndex, offsetBy: 6)
        let bRange = bf..<bt
        let b = String(h[bRange])


        var R: UInt32 = 0x0
        var G: UInt32 = 0x0
        var B: UInt32 = 0x0
        Scanner(string: r).scanHexInt32(&R)
        Scanner(string: g).scanHexInt32(&G)
        Scanner(string: b).scanHexInt32(&B)
        return UIColor.color(CGFloat(R), CGFloat(G), CGFloat(B), A)
    }

}
