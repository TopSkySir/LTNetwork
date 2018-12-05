//
//  LTBaseRequest.swift
//  LTNetwork
//
//  Created by TopSky on 2018/12/3.
//  Copyright © 2018 TopSky. All rights reserved.
//

import UIKit
import Moya

public protocol LTTargetType: TargetType {
    var model: LTTargetModel {set get}
    init(_ model: LTTargetModel)
}

public class LTTarget: LTTargetType {

    public var model: LTTargetModel

    public var baseURL: URL {
        return URL(string: "")!
    }

    public var path: String {
        return model.api
    }

    public var method: Moya.Method {
        return model.method
    }

    public var sampleData: Data {
        return model.sampleData ?? "".data(using: String.Encoding.utf8)!
    }

    public var task: Task {
        return model.task
    }

    public var headers: [String : String]? {
        return model.allHeaders()
    }

    public var validationType: ValidationType {
        return .none
    }

    public required init(_ model: LTTargetModel) {
        self.model = model
    }


}
