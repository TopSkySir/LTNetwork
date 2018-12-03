//
//  Dictionary+LTExtension.swift
//  LTExtensionDemo
//
//  Created by TopSky on 2018/3/2.
//  Copyright © 2018年 TopSky. All rights reserved.
//

import Foundation

public extension Dictionary {

    /**
     获取 String
     */
    func stringValue(_ key: AnyHashable) -> String? {
        return value(key, type: String.self)
    }

    /**
     获取 Safe String
     */
    func stringSafeValue(_ key: AnyHashable) -> String {
        return stringValue(key).safeValue
    }

    /**
     获取 Bool
     */
    func boolValue(_ key: AnyHashable) -> Bool? {
        return value(key, type: Bool.self)
    }

    /**
     获取 Safe Bool
     */
    func boolSafeValue(_ key: AnyHashable) -> Bool {
        return boolValue(key).safeValue
    }

    /**
     获取 Int
     */
    func intValue(_ key: AnyHashable) -> Int? {
        return value(key, type: Int.self)
    }

    /**
     获取 Safe Int
     */
    func intSafeValue(_ key: AnyHashable) -> Int {

        return value(key, type: Int.self).safeValue
    }

    /**
     获取 Float
     */
    func floatValue(_ key: AnyHashable) -> Float? {
        return value(key, type: Float.self)
    }

    /**
     获取 Safe Float
     */
    func floatSafeValue(_ key: AnyHashable) -> Float {
        return value(key, type: Float.self).safeValue
    }

    /**
     获取 Double
     */
    func doubleValue(_ key: AnyHashable) -> Double? {
        return value(key, type: Double.self)
    }

    /**
     获取 Safe Double
     */
    func doubleSafeValue(_ key: AnyHashable) -> Double {
        return value(key, type: Double.self).safeValue
    }

    /**
     键值 类型 映射
     */
    func value<T>(_ key: AnyHashable, type: T.Type) -> T? {
        return (self as [AnyHashable: Any])[key] as? T
    }
}
