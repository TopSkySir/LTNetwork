//
//  LTBaseRequest.swift
//  LTNetwork
//
//  Created by TopSky on 2018/12/3.
//  Copyright © 2018 TopSky. All rights reserved.
//

import Moya

public protocol LTTargetType: TargetType {
    var model: LTTargetModel {set get}
    init(_ model: LTTargetModel)
}

open class LTTarget: LTTargetType {

    open var model: LTTargetModel

    open var baseURL: URL {
        return URL(string: model.baseURL)!
    }

    open var path: String {
        return model.api
    }

    open var method: Moya.Method {
        return model.method
    }

    open var sampleData: Data {
        return model.sampleData ?? "".data(using: String.Encoding.utf8)!
    }

    open var task: Task {
        return model.task
    }

    open var headers: [String : String]? {
        return model.allHeaders()
    }

    open var validationType: ValidationType {
        return .none
    }

    public required init(_ model: LTTargetModel) {
        self.model = model
    }


}
