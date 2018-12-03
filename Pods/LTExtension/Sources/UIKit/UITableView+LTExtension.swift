//
//  UITableView+LTExtension.swift
//  LTExtensionDemo
//
//  Created by TopSky on 2018/3/20.
//  Copyright © 2018年 TopSky. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {

    /**
     注册Cell
     */
    func registerCell<T: UITableViewCell>(_ cellClass: T.Type) {
        let identifier = String(describing: cellClass)
        return register(cellClass, forCellReuseIdentifier: identifier)
    }

    /**
     注册一组Cell
     */
    func registerCell<T: UITableViewCell>(_ cellArr: [T.Type]) {
        cellArr.forEach { (cellClass) in
            registerCell(cellClass)
        }
    }

    /**
     获取Cell
     */
    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type) -> T? {
        let identifier = String(describing: cellClass)
        return dequeueReusableCell(withIdentifier: identifier) as? T
    }

    /**
     注册Header Or Footer
     */
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ registerClass: T.Type) {
        let identifier = String(describing: registerClass)
        register(registerClass, forHeaderFooterViewReuseIdentifier: identifier)

    }

    /**
     注册一组Header Or Footer
     */
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ registerArr: [T.Type]) {
        registerArr.forEach { (registerClass) in
            registerHeaderFooter(registerClass)
        }
    }

    /**
     获取Header Or Footer
     */
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ registerClass: T.Type) -> T? {
        let identifier = String(describing: registerClass)
        return dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T
    }


}
