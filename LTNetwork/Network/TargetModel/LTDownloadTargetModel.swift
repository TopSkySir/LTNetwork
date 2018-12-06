//
//  LTDownLoadModel.swift
//  LTNetwork
//
//  Created by TopSky on 2018/12/6.
//  Copyright © 2018 TopSky. All rights reserved.
//

import UIKit
import Alamofire

class LTDownloadTargetModel: LTTargetModel {

    /**
     文件夹
     */
    var directory: FileManager.SearchPathDirectory = .documentDirectory

    /**
     权限
     */
    var domain: FileManager.SearchPathDomainMask = .userDomainMask

    /**
     文件名称
     */
    var fileName: String?


    override var defaultHeaders: [String : String]? {
        return ["Content-Type": "text/plain"]
    }


    override var task: LTTargetModel.Task {
        var directoryURLs = FileManager.default.urls(for: directory, in: domain)
        let name = fileName
        return .downloadDestination({  (temporaryURL, response) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
            let resultName = name ?? response.suggestedFilename!
            let url = directoryURLs[0].appendingPathComponent(resultName)
            return (url, [.createIntermediateDirectories, .removePreviousFile])
        })
    }
}
