//
//  LTBaseNetworkManager.swift
//  LTNetwork
//
//  Created by TopSky on 2018/12/3.
//  Copyright © 2018 TopSky. All rights reserved.
//

import UIKit
import Moya

public class LTBaseNetworkManager: NSObject {

    @discardableResult
    class func send(_ model: LTBaseRequestModel) -> Cancellable? {
        let request = LTBaseTargetType(model)
        return send(request)
    }


    @discardableResult
    class func send(_ request: LTBaseTargetType) -> Cancellable? {
        let provider = createProvider(request)
        let req = MultiTarget(request)
        return provider.request(req, callbackQueue: DispatchQueue.global(), progress: { (response) in

        }, completion: { (result) in
            switch result {
            case let .success(response):
                let dict = try? JSONSerialization.jsonObject(with: response.data, options: .mutableContainers)
                print(Thread.current)
                print(dict)
            case .failure(let error):
                break
            }
        })
    }


    // MARK: - 创建Provider

    class func createProvider(_ target: LTTargetType) -> MoyaProvider<MultiTarget> {
        return MoyaProvider<MultiTarget>(endpointClosure: createEndpoint,
                                                 requestClosure: createRequest,
                                                 stubClosure: createStub,
                                                 manager: createManager(target),
                                                 plugins: createPlugins(),
                                                 trackInflights: target.model.isTrack)
    }

    /**
     创建Endpoint
     */
    public class func createEndpoint(_ target: MultiTarget) -> Endpoint {
        let realURL = url(target)
        return Endpoint(url: realURL, sampleResponseClosure: { () -> EndpointSampleResponse in
            return .networkResponse(200, target.sampleData)
        }, method: target.method, task: target.task, httpHeaderFields: target.headers)
    }


    /**
     创建Stub
     */
    public class func createStub(_ target: MultiTarget) -> StubBehavior {
        guard let result = target as? LTTargetType, result.model.isStub else {
            return .never
        }
        return .delayed(seconds: 1)
    }

    /**
     创建request
     */
    public class func createRequest(_ endpoint: Endpoint, closure: MoyaProvider<MultiTarget>.RequestResultClosure) {
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
    class func createManager(_ target: LTTargetType) -> Manager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        let manager = Manager(configuration: configuration)
        manager.startRequestsImmediately = false
        return manager
    }

    /**
     创建插件
     */
    public class func createPlugins() -> [PluginType] {
        var plugins = [PluginType]()
        /// 添加状态栏风火轮插件
        let networkPlugin = NetworkActivityPlugin { (change, target)  -> () in
            DispatchQueue.main.async {
                switch(change){
                case .began:
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                case .ended:
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
        plugins.append(networkPlugin)
        return plugins
    }

    // MARK: - 辅助函数

    /**
     获取url
     */
    public class func url(_ target: MultiTarget) -> String {
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
