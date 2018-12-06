//
//  RootViewController.swift
//  TSNaviBarTransitionDemo
//
//  Created by TopSky on 2018/2/8.
//  Copyright © 2018年 TopSky. All rights reserved.
//

import UIKit

class A: LTCodable {
    var name: String = ""
    var address: [B]?
    var item: B?
    var item2: B?

    enum CodingKeys: String, CodingKey{
        case name
        case address
        case item
        case item2 = "item3"
    }
}



class B: Codable {
    var name: String?

}

class RootViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "网络"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }


    override func add() {

        addAction(title: "网络请求") {

            let dict: [String: Any] = ["name": "A", "address":[["name": "b1"],["name": "b2"]], "item": ["name": "b2"], "item3": ["name": "b3"]]

            let model = LTTargetModel()
            model.interface = "http://news-at.zhihu.com/api/2/news/latest"
            model.method = .get
//            model.defaultHeaders = ["A": "1"]
            model.headers = ["B": "2"
            ]
            model.params = ["C": 3]
//            model.defaultParams = ["D": 4]
            model.sampleData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            model.isStub = false
            model.timeoutInterval = 2
//            model.codableType = A.self
            model.completeClosure = { result in
                switch result {
                case .success(let response):
                    print("接收到成功")
                    print(response.object)
                case .failure(let err):
                    print("错误")
                }
            }
            model.progressClosure = { response in
                print(response.progress)
            }
            LTNetwokManager.request(model)
        }

        addAction(title: "Codable") {
            let dict: [String: Any] = ["name": "A", "address":[["name": "b1"],["name": "b2"]], "item": ["name": "b2"], "item3": ["name": "b3"]]
            let model = A.decoder(dict)
            print(model!)
            let dict2 = model?.encoderJson()
            print(dict2! as NSDictionary)
        }

        addAction(title: "下载测试") {
            let model = LTDownloadTargetModel()
            model.interface = "https://dt.80txt.com/73477/%E6%A2%B5%E5%A4%A9%E5%A4%AA%E7%8E%84%E7%BB%8F.txt"
            model.method = .get
            model.fileName = "斗破/全本.txt"
            model.progressClosure = { progress in
                print("进度: \(progress.progress)")
            }
            model.timeoutInterval = 20000
            model.completeClosure = { result in
                print("完成")
                print("\(result.value?.response.response?.suggestedFilename)")
            }
            LTNetwokManager.request(model)
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
