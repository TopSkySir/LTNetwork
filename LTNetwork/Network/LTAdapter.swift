//
//  LTAdapter.swift
//  LTNetwork
//
//  Created by TopSky on 2018/12/5.
//  Copyright © 2018 TopSky. All rights reserved.
//

import UIKit
import Alamofire

class LTAdapter: RequestAdapter {

    /**
     超时时间
     */
    var timeoutInterval: TimeInterval = 30

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var req = urlRequest
        req.timeoutInterval = timeoutInterval
        return req
    }
}
