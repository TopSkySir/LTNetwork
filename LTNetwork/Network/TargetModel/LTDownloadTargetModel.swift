//
//  LTDownLoadModel.swift
//  LTNetwork
//
//  Created by TopSky on 2018/12/6.
//  Copyright © 2018 TopSky. All rights reserved.
//

import UIKit
import Alamofire

public class LTDownloadTargetModel: LTTargetModel {

    /**
     文件夹
     */
    public var directory: FileManager.SearchPathDirectory = .documentDirectory

    /**
     权限
     */
    public var domain: FileManager.SearchPathDomainMask = .userDomainMask

    /**
     文件名称
     */
    public var fileName: String?


    override public var defaultHeaders: [String : String]? {
        return ["Content-Type": "text/plain"]
    }


    override public var task: LTTargetModel.Task {
        var directoryURLs = FileManager.default.urls(for: directory, in: domain)
        let name = fileName
        return .downloadDestination({  (temporaryURL, response) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
            let resultName = name ?? response.suggestedFilename!
            let url = directoryURLs[0].appendingPathComponent(resultName)
            return (url, [.createIntermediateDirectories, .removePreviousFile])
        })
    }
}

