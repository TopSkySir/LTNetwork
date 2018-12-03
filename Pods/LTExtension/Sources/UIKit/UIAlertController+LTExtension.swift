//
//  UIAlertController+LTExtension.swift
//  LTExtensionDemo
//
//  Created by TopSky on 2018/3/27.
//  Copyright © 2018年 TopSky. All rights reserved.
//

import Foundation
import UIKit


// MARK: - 属性
public extension UIAlertController {

    /**
     设置标题富文本
     */
    func setTitleAttribute(_ title: NSAttributedString) {
        setValue(title, forKey: "attributedTitle")
    }

    /**
     设置信息富文本
     */
    func setMessageAttribute(_ message: NSAttributedString) {
        setValue(message, forKey: "attributedMessage")
    }

}


// MARK: - 方法

public extension UIAlertController {

    /**
     AlertText 常用文案
     */
    struct AlertText {
        public static let Sure: String = "确定"
        public static let Cancel: String = "取消"
        public static let Yes: String = "是"
        public static let NO: String = "否"
        public static let OK: String = "好的"
    }

    /**
     Action 闭包
     */
    typealias ActionClosure = () -> Void

    /**
     新增Action
     */
    func addAction(title: String?, style: UIAlertActionStyle, closure: ActionClosure? = nil) {
        guard let resultTitle = title else {
            return
        }
        let resultAction = UIAlertAction(title: resultTitle, style: style) { (action) in
            if let resultClosure = closure {
                resultClosure()
            }
        }
        addAction(resultAction)
    }

    /**
    显示一个按钮的Alert
     */
    static func showSingleAlert(_ target: UIViewController?, title: String?, message: String?, sureTitle: String? = AlertText.Sure, sureClosure: ActionClosure? = nil) {
        showAlert(target, title: title, message: message, sureTitle: sureTitle, sureClosure: sureClosure, cancelTitle: nil, cancelClosure: nil)
    }


    /**
     显示两个 或两个以下的Alert
     */
    static func showAlert(_ target: UIViewController?, title: String?, message: String?, sureTitle: String? = AlertText.Sure, sureClosure: ActionClosure?, cancelTitle: String? = AlertText.Cancel, cancelClosure: ActionClosure? = nil) {

        /**
         标题校验
         */
        if title == nil && message == nil {
            return
        }

        /**
         按钮校验
         */
        if sureTitle == nil && cancelTitle == nil {
            return
        }

        /**
         设置标题和文案
         */
        let alertVC = self.init(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertVC.addAction(title: sureTitle, style: .default, closure: sureClosure)
        alertVC.addAction(title: cancelTitle, style: .cancel, closure: cancelClosure)

        /**
         弹起
         */
        guard let resultTarget = target  else {
            UIApplication.topViewController()?.presentTo(alertVC)
            return
        }
        resultTarget.presentTo(alertVC)
    }

}
