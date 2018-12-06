//
//  LTResponse.swift
//  LTNetwork
//
//  Created by TopSky on 2018/12/4.
//  Copyright © 2018 TopSky. All rights reserved.
//

import UIKit
import Moya
import Result

public typealias LTProgress = (_ progress: ProgressResponse) -> Void
public typealias LTCompletion = (_ result: Result<LTResponse, AnyError>) -> Void

public class LTResponse: NSObject {

    /**
     Moya 返回的Response
     */
    public var response: Response

    /**
     附加冗余字段
     */
    public var object: Any?

    /**
     附加冗余字段
     */
    public var userInfo: Any?


    public required init(_ response: Response) {
        self.response = response
    }

}
