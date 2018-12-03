//
//  RootViewController.swift
//  TSNaviBarTransitionDemo
//
//  Created by TopSky on 2018/2/8.
//  Copyright © 2018年 TopSky. All rights reserved.
//

import UIKit


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
            let model = LTBaseRequestModel()
            model.interface = "http://news-at.zhihu.com/api/2/news/latest"
            model.method = .get
            LTBaseNetworkManager.send(model)
        }

        addAction(title: "系统风火轮---开") {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }

        addAction(title: "系统风火轮---关") {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
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
