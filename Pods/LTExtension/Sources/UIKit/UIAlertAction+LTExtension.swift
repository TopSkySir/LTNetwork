//
//  UIAlertAction+LTExtension.swift
//  LTCustomProtocol
//
//  Created by TopSky on 2018/3/28.
//

import Foundation
import UIKit
// MARK: - 属性

public extension UIAlertAction {

    /**
     设置文本颜色
     */
    func setTextColor(_ color: UIColor) {
        setValue(color, forKey: "titleTextColor")
    }

}
