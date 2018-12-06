//
//  LTBaseRequestModel.swift
//  LTNetwork
//
//  Created by TopSky on 2018/12/3.
//  Copyright © 2018 TopSky. All rights reserved.
//

import UIKit
import Moya
import Alamofire

public class LTTargetModel: NSObject {

    public typealias Method = Moya.Method
    public typealias ParameterEncoding = Moya.ParameterEncoding
    public typealias Task = Moya.Task

    /**
     接口 设置之后 默认 baseURL+api拼接模式失效
     */
    public var interface: String = ""

    /**
     接口基路径
     */
    public var baseURL: String = ""

    /**
     api路径
     */
    public var api: String = ""

    /**
     请求方式
     */
    public var method: Method = .get

    /**
     头部参数
     */
    public var headers: [String: String]?

    /**
     默认头部参数， 基类可配置此选项
     */
    public var defaultHeaders: [String: String]? {
        return nil
    }

    /**
     参数
     */
    public var params: [String: Any]?

    /**
     默认参数， 基类可配置此选项
     */
    public var defaultParams: [String: Any]? {
        return nil
    }

    /**
     参数编码格式
     */
    public var paramsEncodeing: ParameterEncoding = URLEncoding.default

    /**
     任务类型
     */
    public var task: Task {
        guard let result = allParams(), !result.isEmpty else {
            return .requestPlain
        }
        return .requestParameters(parameters: result, encoding: paramsEncodeing)
    }

    /**
     插件
     */
    public var plugins: [LTPluginType] = [LTParsePlugin(), LTCompletePlugin()]


    /**
     适配器
     */
    public var adapter: RequestAdapter{
        let adapter = LTAdapter()
        adapter.timeoutInterval = timeoutInterval
        return adapter
    }


    /**
     超时时间
     */
    public var timeoutInterval: TimeInterval = 30

    /**
     是否跟踪重复的网络请求
     */
    public var trackInflights: Bool = false

    /**
     样本模拟数据 
     */
    public var sampleData: Data?

    /**
     是否执行模拟数据
     */
    public var isStub: Bool = false

    /**
     model转换
     */
    public var codableType: LTCodable.Type?

    /**
     进度回调
     */
    public var progressClosure: LTProgress?

    /**
     完成回调
     */
    public var completeClosure: LTCompletion?

}

public extension LTTargetModel {

    /**
     获取拼接后的header
     */
    func allHeaders() -> [String: String]? {
        return appendDict(lhs: headers, rhs: defaultHeaders) as? [String: String]
    }

    /**
     获取拼接后的Params
     */
    func allParams() -> [String: Any]? {
        return appendDict(lhs: params, rhs: defaultParams)
    }

    /**
     字典拼接
     */
    func appendDict(lhs: [String: Any]?, rhs: [String: Any]?) -> [String: Any]? {
        guard var lResult = lhs, !lResult.isEmpty else {
            return rhs
        }

        guard let rResult = rhs, !rResult.isEmpty else {
            return lhs
        }

        for (key,value) in rResult {
            lResult[key] = value
        }
        return lResult
    }
    
}
