//
//  Array+LTExtension.swift
//  LTExtensionDemo
//
//  Created by TopSky on 2018/2/28.
//  Copyright © 2018年 TopSky. All rights reserved.
//

import Foundation

public extension Array where Element: Equatable {

    /**
     移除第一个相等的元素
     */
    mutating func remove(of element: Element){
        if let index = self.index(of: element) {
            self.remove(at: index)
        }
    }

}

public extension Array {


    // MARK: - 安全
    
    /**
     下标是否安全,数组是否越界
     */
    func isSafe(_ index: Int) -> Bool {
        let range = 0..<self.count
        return range.contains(index)
    }


    /**
     取值的安全扩展
     */
    func safe(index: Int) -> Element? {
        guard isSafe(index) else {
            return nil
        }
        return self[index]
    }

    /**
     下标取值的安全扩展
     */
    subscript (safe index: Int) -> Element? {
        return safe(index: index)
    }


    // MARK: - 位置

    /**
     交换位置
     */
    mutating func exchange(_ from: Int, _ to: Int) {
        guard from != to else {
            return
        }

        guard isSafe(from), isSafe(to) else {
            return
        }
        let tempFrom = self[from]
        let tempTo = self[to]
        self.remove(at: from)
        self.insert(tempTo, at: from)
        self.remove(at: to)
        self.insert(tempFrom, at: to)

    }


    /**
     移动
     from: 起始位置
     to: 结束位置
     */
    mutating func move(_ from: Int, _ to: Int) {
        guard from != to else {
            return
        }

        guard isSafe(from), isSafe(to) else {
            return
        }

        let temp = self[from]
        self.remove(at: from)
        self.insert(temp, at: to)
    }

    /**
     移动尾部
     from: 起始位置
     */
    mutating func moveLast(_ from: Int) {
        move(from, self.count-1)
    }

    /**
     移动头部
     */
    mutating func moveFirst(_ from: Int) {
        move(from, 0)
    }
}
