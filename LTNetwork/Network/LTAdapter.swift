//
//  LTAdapter.swift
//  LTNetwork
//
//  Created by TopSky on 2018/12/5.
//  Copyright © 2018 TopSky. All rights reserved.
//

import UIKit
import Alamofire

open class LTAdapter: RequestAdapter {

    /**
     超时时间
     */
    open var timeoutInterval: TimeInterval = 30

    open func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var req = urlRequest
        req.timeoutInterval = timeoutInterval
        return req
    }
}
