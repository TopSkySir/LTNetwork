//
//  LTTestPlugin.swift
//  LTNetwork
//
//  Created by TopSky on 2018/12/5.
//  Copyright © 2018 TopSky. All rights reserved.
//

import UIKit
import Moya
import Result

class LTTestPlugin: LTPluginType {

    deinit {
        print("LTTestPlugin deinit")
    }

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        print("准备")
        return request
    }

    func willSend(_ request: RequestType, target: TargetType) {
        print("发送")
    }

    func progress(_ response: ProgressResponse) {
        print("过程: \(response.progress)")
    }

    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        print("装饰")
        return result
    }

    func complete(_ result: Result<LTResponse, AnyError>, target: LTTargetType) -> Result<LTResponse, AnyError> {
        switch result {
        case .success(let response):
            print("=====")
            print(response.object)
            print("=====")
        default:
            break
        }
        print("完成")
        return result
    }

}
