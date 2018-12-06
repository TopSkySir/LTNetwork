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

open class LTTargetModel: NSObject {

    public typealias Method = Moya.Method
    public typealias ParameterEncoding = Moya.ParameterEncoding
    public typealias Task = Moya.Task

    /**
     接口 设置之后 默认 baseURL+api拼接模式失效
     */
    open var interface: String = ""

    /**
     接口基路径
     */
    open var baseURL: String {
        return ""
    }

    /**
     api路径
     */
    open var api: String = ""

    /**
     请求方式
     */
    open var method: Method = .get

    /**
     头部参数
     */
    open var headers: [String: String]?

    /**
     默认头部参数， 基类可配置此选项
     */
    open var defaultHeaders: [String: String]? {
        return nil
    }

    /**
     参数
     */
    open var params: [String: Any]?

    /**
     默认参数， 基类可配置此选项
     */
    open var defaultParams: [String: Any]? {
        return nil
    }

    /**
     参数编码格式
     */
    open var paramsEncodeing: ParameterEncoding = URLEncoding.default

    /**
     任务类型
     */
    open var task: Task {
        guard let result = allParams(), !result.isEmpty else {
            return .requestPlain
        }
        return .requestParameters(parameters: result, encoding: paramsEncodeing)
    }

    /**
     插件
     */
    open var plugins: [LTPluginType] {
        return [LTParsePlugin(), LTCompletePlugin()]
    }

    /**
     适配器
     */
    open var adapter: RequestAdapter{
        let adapter = LTAdapter()
        adapter.timeoutInterval = timeoutInterval
        return adapter
    }


    /**
     超时时间
     */
    open var timeoutInterval: TimeInterval = 30

    /**
     是否跟踪重复的网络请求
     */
    open var trackInflights: Bool = false

    /**
     样本模拟数据 
     */
    open var sampleData: Data?

    /**
     是否执行模拟数据
     */
    open var isStub: Bool = false

    /**
     model转换
     */
    open var codableType: LTCodable.Type?

    /**
     进度回调
     */
    open var progressClosure: LTProgress?

    /**
     完成回调
     */
    open var completeClosure: LTCompletion?

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
