//
//  LTAdapter.swift
//  LTNetwork
//
//  Created by TopSky on 2018/12/5.
//  Copyright © 2018 TopSky. All rights reserved.
//

import UIKit
import Alamofire

public class LTAdapter: RequestAdapter {

    /**
     超时时间
     */
    public var timeoutInterval: TimeInterval = 30

    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var req = urlRequest
        req.timeoutInterval = timeoutInterval
        return req
    }
}
