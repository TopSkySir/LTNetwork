//
//  LTParsePlugin.swift
//  LTNetwork
//
//  Created by TopSky on 2018/12/4.
//  Copyright © 2018 TopSky. All rights reserved.
//

import Moya
import Result

open class LTParsePlugin: LTPluginType {

    open func complete(_ result: Result<LTResponse, AnyError>, target: LTTargetType) -> Result<LTResponse, AnyError> {
        switch result {
        case .success(let response):
            let data = response.response.data
            guard let codableType = target.model.codableType else {
                response.object = parse(data)
                break
            }
            response.object = codableType.decoder(data)
        default:
            break
        }
        return result
    }

    // MARK: - 解析

    open func parse(_ data: Data?) -> [String: Any]? {
        guard let resultData = data else {
            return nil
        }
        let dict = (try? JSONSerialization.jsonObject(with: resultData, options: .mutableContainers)) as? [String: Any]
        return dict
    }
}
