//
//  UICollectionView+LTExtension.swift
//  LTExtensionDemo
//
//  Created by TopSky on 2018/3/20.
//  Copyright © 2018年 TopSky. All rights reserved.
//

import Foundation
import UIKit

public extension UICollectionView {

    /**
     注册Cell
     */
    func registerCell<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let identifier = String(describing: cellClass)
        return register(cellClass, forCellWithReuseIdentifier: identifier)
    }

    /**
     注册一组Cell
     */
    func registerCell<T: UICollectionViewCell>(_ cellArr: [T.Type]) {
        cellArr.forEach { (cellClass) in
            registerCell(cellClass)
        }
    }

    /**
     获取Cell
     */
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, indexPath: IndexPath) -> T? {
        let identifier = String(describing: cellClass)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T
    }

    /**
     注册Header
     */
    func registerHeader<T: UICollectionReusableView>(_ registerClass: T.Type) {
        let identifier = String(describing: registerClass)
        return register(registerClass, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: identifier)
    }


    /**
     注册一组Header
     */
    func registerHeader<T: UICollectionReusableView>(_ registerArr: [T.Type]) {
        registerArr.forEach { (registerClass) in
            registerHeader(registerClass)
        }
    }

    /**
     获取Header
     */
    func dequeueReusableHeader<T: UICollectionReusableView>(_ registerClass: T.Type, indexPath: IndexPath) -> T? {
        let identifier = String(describing: registerClass)
        return dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: identifier, for: indexPath) as? T
    }


    /**
     注册Footer
     */
    func registerFooter<T: UICollectionReusableView>(_ registerClass: T.Type) {
        let identifier = String(describing: registerClass)
        return register(registerClass, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: identifier)
    }

    /**
     注册一组Footer
     */
    func registerFooter<T: UICollectionReusableView>(_ registerArr: [T.Type]) {
        registerArr.forEach { (registerClass) in
            registerFooter(registerClass)
        }
    }

    /**
    获取Footer
     */
    func dequeueReusableFooter<T: UICollectionReusableView>(_ registerClass: T.Type, indexPath: IndexPath) -> T? {
        let identifier = String(describing: registerClass)
        return dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: identifier, for: indexPath) as? T
    }

}
