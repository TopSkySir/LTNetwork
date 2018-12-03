//
//  UITextField+LTExtension.swift
//  LTExtensionDemo
//
//  Created by TopSky on 2018/3/8.
//  Copyright © 2018年 TopSky. All rights reserved.
//

import Foundation
import UIKit

public extension UITextField {

    /**
     设置占位颜色
     */
    func placeholderColor(_ color: UIColor) {
        setValue(color, forKeyPath: "_placeholderLabel.textColor")
    }

    /**
     设置占位字号
     */
    func placeholderFont(_ font: UIFont) {
        setValue(font, forKeyPath: "_placeholderLabel.font")
    }

}
