//
//  Optional+LTExtension.swift
//  LTExtensionDemo
//
//  Created by TopSky on 2018/2/26.
//  Copyright © 2018年 TopSky. All rights reserved.
//

import Foundation

public extension Optional where Wrapped: Collection{

    /**
     判断是否为 nil or empty
     */
    var isNilOrEmpty: Bool {
        guard !isNil else {
            return true
        }
        return unsafelyUnwrapped.isEmpty
    }

    /**
     获取集合总量
     w: Wrapped
     nil： count = 0
     */
    var safeCount: Int {
        guard !isNil else {
            return 0
        }
        return Int(unsafelyUnwrapped.count)
    }

}

public extension Optional {

    /**
     判断是否为nil
     */
    var isNil: Bool {
        return self == nil
    }

}

public extension Optional where Wrapped == Bool {

    /**
     Bool拆包 安全值
     */
    var safeValue: Bool {
        return safe(false)
    }
}

public extension Optional where Wrapped == String {

    /**
     字符串拆包 安全值 
     */
    var safeValue: String {
        return safe("")
    }
}

public extension Optional where Wrapped: Numeric {

    /**
     数值类拆包 安全值
     */
    var safeValue: Wrapped {
        return safe(0)
    }
}

public extension Optional {

    /**
     Optional 安全拆包方法
     */
    func safe(_ value: Wrapped) -> Wrapped {
        guard self == nil else {
            return unsafelyUnwrapped
        }
        return value
    }
}

