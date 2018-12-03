//
//  UIImage+LTExtension.swift
//  LTExtensionDemo
//
//  Created by TopSky on 2018/3/8.
//  Copyright © 2018年 TopSky. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {


    class func image(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1), alpha: CGFloat = 1) -> UIImage? {
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setAlpha(alpha)
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

}

