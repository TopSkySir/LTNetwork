//
//  LTCompletePlugin.swift
//  LTNetwork
//
//  Created by TopSky on 2018/12/6.
//  Copyright © 2018 TopSky. All rights reserved.
//

import UIKit
import Moya
import Result

public class LTCompletePlugin: LTPluginType {

    public func progress(_ response: ProgressResponse, target: LTTargetType) {
        guard let progress = target.model.progressClosure else {
            return
        }
        progress(response)
    }

    public func complete(_ result: Result<LTResponse, AnyError>, target: LTTargetType) -> Result<LTResponse, AnyError> {
        guard let complete = target.model.completeClosure else {
            return result
        }
        DispatchQueue.main.async {
            complete(result)
        }
        return result
    }
}
