//
//  UIApplication+LTExtension.swift
//  LTExtensionDemo
//
//  Created by TopSky on 2018/3/9.
//  Copyright © 2018年 TopSky. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Version
public extension UIApplication {

    /**
     包ID
     */
    static let appBundleID = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as! String

    /**
     包名
     */
    static let appBundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String

    /**
     build版本号
     */
    static let appBuildVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String

    /**
     版本号
     */
    static let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

}


// MARK: - UI
public extension UIApplication {

    /**
     获取顶部 window
     */
    class func topWindow() -> UIWindow? {
        var keyWindow = UIApplication.shared.keyWindow
        if keyWindow?.windowLevel != UIWindowLevelNormal {
            for tempWindow in UIApplication.shared.windows {
                if tempWindow.windowLevel == UIWindowLevelNormal{
                    keyWindow = tempWindow
                    break
                }
            }
        }
        return keyWindow
    }


    /**
     获取顶部 viewController
     */
    class func topViewController() -> UIViewController? {
        var result = topWindow()?.rootViewController;
        result = topViewController(result)
        return result;
    }


    /**
     根据root 获取顶部 viewController
     */
    class func topViewController(_ root: UIViewController?) -> UIViewController? {
        if let tab = root as? UITabBarController {
            return topViewController(tab.selectedViewController)
        } else if let navi = root as? UINavigationController {
            return topViewController(navi.visibleViewController)
        } else if let present = root?.presentedViewController {
            return topViewController(present)
        } else {
            return root
        }
    }


    /**
     获取APP的根视图
     */
    class func appRootViewController() -> UIViewController? {
        return UIApplication.shared.delegate?.window??.rootViewController
    }


    /**
     获取tabBar上的根UINavigationController
     */
    class func tabNavi(_ index: Int) -> UINavigationController? {
        guard let tab = appRootViewController() as? UITabBarController else {
            return nil
        }

        guard let arr = tab.viewControllers else {
            return nil
        }

        guard arr.count > index  else {
            return nil
        }

        return arr[index] as? UINavigationController
    }

    /**
     切换tabBar
     */
    class func selectedTab(_ index: Int) {
        guard let tab = appRootViewController() as? UITabBarController else {
            return
        }

        guard let arr = tab.viewControllers else {
            return
        }

        guard arr.count > index  else {
            return
        }

        tab.selectedIndex = index
    }
}

