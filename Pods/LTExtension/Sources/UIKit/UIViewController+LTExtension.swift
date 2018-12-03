//
//  UIViewController+LTExtension.swift
//  LTExtensionDemo
//
//  Created by TopSky on 2018/3/8.
//  Copyright © 2018年 TopSky. All rights reserved.
//

import Foundation
import UIKit



public extension UIViewController {

    /**
     返回
     */
    @objc func goBack(_ animated: Bool = true) {
        if presentingViewController != nil {
            if let count = navigationController?.viewControllers.count {
                if count > 1 {
                    popBack(animated)
                } else {
                    dismissBack(animated)
                }
            } else {
                dismissBack(animated)
            }
        } else {
            popBack(animated)
        }
    }

    /**
     pop返回
     */
    @objc func popBack(_ animated: Bool = true){
        navigationController?.popViewController(animated: true)
    }


    /**
     dissmiss返回
     */
    @objc func dismissBack(_ animated: Bool = true) {
        dismiss(animated: animated, completion: nil)
    }


    /**
     pop到指定的viewController
     isLast: true 最近的一个 false 最远的一个
     animated: 是否需要动画
     */
    func popTo<T: UIViewController>(_ type: T.Type, _ isLast: Bool = true, _ animated: Bool = true) {
        let arr = navigationController?.viewControllers.filter({$0 .isKind(of: T.self)})
        let viewController = isLast ? arr?.last : arr?.first
        guard let resultVC = viewController else {
            return
        }
        navigationController?.popToViewController(resultVC, animated: animated)
    }


    /**
     push到下一个viewController
     */
    func pushTo(_ viewController: UIViewController?, _ animated: Bool = true) {
        guard let resultVC = viewController  else {
            return
        }
        resultVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(resultVC, animated: animated)
    }

    /**
     present到下一个viewController
     */
    func presentTo(_ viewController: UIViewController?, _ animated: Bool = true) {
        guard let resultVC = viewController  else {
            return
        }
        present(resultVC, animated: animated, completion: nil)
    }

}
