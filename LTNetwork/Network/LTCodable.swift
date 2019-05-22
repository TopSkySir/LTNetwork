//
//  LTCodable.swift
//  LTNetwork
//
//  Created by TopSky on 2018/12/5.
//  Copyright © 2018 TopSky. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import Cocoa
#endif


public protocol LTCodable: Codable {
    static func decoder(_ data: Data?) -> Self?
    static func decoder(_ dict: [String: Any]?) -> Self?
    func encoderData() -> Data?
    func encoderJson() -> [String: Any]?
}


// MARK: - 类型转换

public extension LTCodable {

    /**
     Data 转 Model
     */
    static func decoder(_ data: Data?) -> Self? {
        guard let data = data else {
            return nil
        }
        return try? JSONDecoder().decode(self, from: data)
    }

    /**
     字典 转 Model
     */
    static func decoder(_ dict: [String: Any]?) -> Self? {
        guard let dict = dict else {
            return nil
        }
        let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        return decoder(data)
    }

    /**
     Model 转 Data
     */
    func encoderData() -> Data? {
        return try? JSONEncoder().encode(self)
    }

    /**
     Model 转 字典
     */
    func encoderJson() -> [String: Any]? {
        guard let data = encoderData() else {
            return nil
        }
        return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [String : Any]
    }
}
