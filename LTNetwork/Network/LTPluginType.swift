//
//  LTPluginType.swift
//  LTNetwork
//
//  Created by TopSky on 2018/12/4.
//  Copyright © 2018 TopSky. All rights reserved.
//

import UIKit
import Moya
import Result

public protocol LTPluginType: PluginType {

    func progress(_ response: ProgressResponse, target: LTTargetType)

    func complete(_ result: Result<LTResponse, AnyError>, target: LTTargetType) -> Result<LTResponse, AnyError>

}

public extension LTPluginType {

    func progress(_ response: ProgressResponse, target: LTTargetType) {
        return
    }

    func complete(_ result: Result<LTResponse, AnyError>, target: LTTargetType) -> Result<LTResponse, AnyError> {
        return result
    }

}

