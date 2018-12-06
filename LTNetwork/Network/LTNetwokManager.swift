//
//  LTBaseNetworkManager.swift
//  LTNetwork
//
//  Created by TopSky on 2018/12/3.
//  Copyright © 2018 TopSky. All rights reserved.
//

import UIKit
import Moya
import Result

open class LTNetwokManager: NSObject {

    @discardableResult
    open class func request(_ model: LTTargetModel) -> Cancellable? {
        let target = LTTarget(model)
        return request(target)
    }

    @discardableResult
    open class func request(_ target: LTTarget) -> Cancellable? {
        let provider = createProvider(target)
        let resultTarget = MultiTarget(target)
        return provider.request(resultTarget, callbackQueue: DispatchQueue.global(), progress: { [weak target] (response) in
            perform(response, target: target)
        }, completion: { [weak target] (result) in
            perform(result, target: target)
        })
    }


    // MARK: - 创建Provider

    open class func createProvider(_ target: LTTargetType) -> MoyaProvider<MultiTarget> {
        return MoyaProvider<MultiTarget>(endpointClosure: createEndpoint,
                                                 requestClosure: createRequest,
                                                 stubClosure: createStub,
                                                 manager: createManager(target),
                                                 plugins: createPlugins(target),
                                                 trackInflights: target.model.trackInflights)
    }

    /**
     创建Endpoint
     */
    open class func createEndpoint(_ target: MultiTarget) -> Endpoint {
        let realURL = url(target)
        return Endpoint(url: realURL, sampleResponseClosure: { () -> EndpointSampleResponse in
            return .networkResponse(200, target.sampleData)
        }, method: target.method, task: target.task, httpHeaderFields: target.headers)
    }


    /**
     创建Stub
     */
    open class func createStub(_ target: MultiTarget) -> StubBehavior {
        guard let result = target.target as? LTTargetType, result.model.isStub else {
            return .never
        }
        return .delayed(seconds: 1)
    }

    /**
     创建request
     */
    open class func createRequest(_ endpoint: Endpoint, closure: MoyaProvider<MultiTarget>.RequestResultClosure) {
        do {
            let urlRequest = try endpoint.urlRequest()
            closure(.success(urlRequest))
        } catch MoyaError.requestMapping(let url) {
            closure(.failure(MoyaError.requestMapping(url)))
        } catch MoyaError.parameterEncoding(let error) {
            closure(.failure(MoyaError.parameterEncoding(error)))
        } catch {
            closure(.failure(MoyaError.underlying(error, nil)))
        }
    }

    /**
     创建Manager
     */
    open class func createManager(_ target: LTTargetType) -> Manager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        let manager = Manager(configuration: configuration)
        manager.startRequestsImmediately = false
        manager.adapter = target.model.adapter
        return manager
    }

    /**
     创建插件
     */
    open class func createPlugins(_ target: LTTargetType) -> [PluginType] {
        return target.model.plugins
    }


    // MARK: - 插件回调

    /**
     progress回调
     */
    open class func perform(_ response: ProgressResponse, target: LTTarget?) {
        guard let target = target else {
            return
        }
        target.model.plugins.forEach({ (item) in
            item.progress(response, target: target)
        })
    }


    /**
     complete回调
     */
    open class func perform(_ result: Result<Moya.Response, MoyaError>, target: LTTarget?) {
        guard let target = target else {
            return
        }
        var convertResult: Result<LTResponse, AnyError>
        switch result {
        case .success(let response):
            let convertResponse = LTResponse(response)
            convertResult = Result<LTResponse, AnyError>.success(convertResponse)
        case .failure(let error):
            let convertError = AnyError.init(error)
            convertResult = Result<LTResponse, AnyError>.failure(convertError)
        }
        let _ = target.model.plugins.reduce(convertResult) { $1.complete($0, target: target)}
    }


    // MARK: - 辅助函数

    /**
     获取url
     */
    open class func url(_ target: MultiTarget) -> String {
        guard let result = target.target as? LTTargetType else {
            return ""
        }

        /**
         优先使用全路径拼接interface
         */
        let interface = result.model.interface
        guard interface.count == 0 else {
            return interface
        }

        /**
         使用路径拼接
         */
        return URL(target: target).absoluteString
    }


}
