//
//  UIResponder+LTExtension.swift
//  LTExtensionDemo
//
//  Created by TopSky on 2018/5/3.
//  Copyright © 2018年 TopSky. All rights reserved.
//

import Foundation
import UIKit

public protocol UIResponderConfigProtocol where Self: UIResponder {

}

public extension UIResponderConfigProtocol {

    /**
     申明常量时 直接添加配置 用于视图布局
     注意: iOS8一下 避免直接在closure中 调用self 相关, 以免引起crash
     */
    static func setConfig(_ closure: (Self) -> Void) -> Self {
        let result = Self.init()
        closure(result)
        return result
    }

}

extension UIResponder: UIResponderConfigProtocol {

}
