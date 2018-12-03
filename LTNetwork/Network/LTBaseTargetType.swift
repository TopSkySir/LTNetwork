//
//  LTBaseRequest.swift
//  LTNetwork
//
//  Created by TopSky on 2018/12/3.
//  Copyright © 2018 TopSky. All rights reserved.
//

import UIKit
import Moya

protocol LTTargetType: TargetType {
    var model: LTBaseRequestModel {set get}
    init(_ model: LTBaseRequestModel)
}

class LTBaseTargetType: LTTargetType {
    var model: LTBaseRequestModel

    var baseURL: URL {
        return URL(string: "")!
    }

    var path: String {
        return model.api
    }

    var method: Moya.Method {
        return model.method
    }

    var sampleData: Data {
        return model.sampleData ?? "".data(using: String.Encoding.utf8)!
    }

    var task: Task {
        return model.task
    }

    var headers: [String : String]? {
        return model.headers
    }

    required init(_ model: LTBaseRequestModel) {
        self.model = model
    }

}
