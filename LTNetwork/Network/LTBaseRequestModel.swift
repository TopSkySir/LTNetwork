//
//  LTBaseRequestModel.swift
//  LTNetwork
//
//  Created by TopSky on 2018/12/3.
//  Copyright © 2018 TopSky. All rights reserved.
//

import UIKit
import Moya

class LTBaseRequestModel: NSObject {

    typealias Method = Moya.Method
    typealias ParameterEncoding = Moya.ParameterEncoding
    typealias Task = Moya.Task

    var interface: String = ""
    var baseURL: String = ""
    var api: String = ""
    var method: Method = .get
    var params: [String: Any]?
    var defaultParams: [String: Any]?
    var headers: [String: String]?
    var defaultHeaders: [String: String]?
    var paramsEncodeing: ParameterEncoding = URLEncoding.default
    var task: Task = .requestPlain
    var sampleData: Data?
    var validate: Bool = false
    var timeOut: TimeInterval = 30
    var isTrack: Bool = true
    var isStub: Bool = false

}
