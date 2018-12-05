//
//  LTParsePlugin.swift
//  LTNetwork
//
//  Created by TopSky on 2018/12/4.
//  Copyright © 2018 TopSky. All rights reserved.
//

import UIKit
import Moya
import Result

public class LTParsePlugin: LTPluginType {

    deinit {
        print("LTParsePlugin  deinit")
    }

    public func complete(_ result: Result<LTResponse, AnyError>, target: LTTargetType) -> Result<LTResponse, AnyError> {
        switch result {
        case .success(let response):
            response.object = parse(response.response.data)
        default:
            break
        }
        return result
    }

    // MARK: - 解析
    
    public func parse(_ data: Data?) -> [String: Any]? {
        guard let resultData = data else {
            return nil
        }
        let dict = (try? JSONSerialization.jsonObject(with: resultData, options: .mutableContainers)) as? [String: Any]
        return dict
    }
}
