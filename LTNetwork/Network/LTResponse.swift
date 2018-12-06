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

open class LTResponse: NSObject {

    /**
     Moya 返回的Response
     */
    open var response: Response

    /**
     附加冗余字段
     */
    open var object: Any?

    /**
     附加冗余字段
     */
    open var userInfo: Any?


    public required init(_ response: Response) {
        self.response = response
    }

}
