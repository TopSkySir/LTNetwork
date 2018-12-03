//
//  String+LTExtension.swift
//  LTExtensionDemo
//
//  Created by TopSky on 2018/2/27.
//  Copyright © 2018年 TopSky. All rights reserved.
//

import Foundation
import UIKit

public extension String {

    /**
     去除空白字符串
     */
    func trim() -> String {
        return trimmingCharacters(in: .whitespaces)
    }

    /**
     去除换行和空白字符串
     */
    func completeTrim() -> String {
        var result = replace("\n", "")
        result = result.replace("\r", "")
        result = result.replace("\t", "")
        return result.trimmingCharacters(in: .whitespaces)
    }

    /**
     替换字符串
     */
    func replace(_ target: String, _ replacement: String) -> String {
        return replacingOccurrences(of: target, with: replacement)
    }


    /**
     截取字符串
     */
    subscript (from: Int, to: Int) -> String {
        let f = min(max(0, from), self.count - 1)
        let t = min(max(0, to), self.count - 1)
        let fromIndex = index(self.startIndex, offsetBy: f)
        let toIndex = index(self.startIndex, offsetBy: t)
        var range: ClosedRange<String.Index>
        if f > t {
            range = toIndex...fromIndex
        } else {
            range = fromIndex...toIndex
        }
        return String(self[range])
    }


    /**
     截取字符串
     */
    func substring(_ range: NSRange) -> String {
        return NSString(string: self).substring(with: range)
    }

    /**
     获取文件后缀名 （不带.）
     */
    func pathExtension() -> String {
        return NSString(string: self).pathExtension
    }

    /**
     从路径中获得完整的文件名（带后缀）
     */
    func lastPathComponent() ->String {
        return NSString(string: self).lastPathComponent
    }

    /**
     获得文件名（不带后缀）
     */
    func deletingPathExtension() ->String {
        return NSString(string: self).deletingPathExtension
    }
}


// MARK: - 正则

public extension String {

    /**
     正则替换字符
     */
    func replace(pattern:String, template:String) -> String {

        guard !isEmpty else {
            return self
        }

        do {
            let regularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)

            return regularExpression.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, count), withTemplate: template)
        } catch {
            return self
        }
    }

    /**
     正则搜索相关字符位置
     */
    func matches(pattern:String) -> [NSTextCheckingResult] {
        guard !isEmpty else {
            return []
        }
        do {
            let regularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)

            return regularExpression.matches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, count))

        } catch {
            return []
        }
    }

    /**
     是否存在正则匹配到的内容
     */
    func isMatch(pattern:String) ->Bool {
        let result:[NSTextCheckingResult] = matches(pattern: pattern)
        return !result.isEmpty
    }

}


// MARK: - 数据转换
public extension String {

    /**
     整型
     */
    var intValue: Int? {
        return Int(self)
    }

    /**
     获取整型
     默认0
     */
    func getIntValue(_ defaultValue: Int = 0) -> Int {
        return intValue.safe(defaultValue)
    }

    /**
     Float
     */
    var floatValue: Float? {
        return Float(self)
    }

    /**
     获取Float
     默认0
     */
    func getFloatValue(_ defaultValue: Float = 0) -> Float {
        return floatValue.safe(defaultValue)
    }

    /**
     Double
     */
    var doubleValue: Double?{
        return Double(self)
    }

    /**
     获取Double
     默认0
     */
    func getDoubleValue(_ defaultValue: Double = 0) -> Double {
        return doubleValue.safe(defaultValue)
    }
}


// MARK: - 获取字符串宽高
public extension String {

    /**
     获取字符串Size
     */
    func size(_ font: UIFont, contentSize: CGSize = CGSize.zero) -> CGSize {
        let rect = self.boundingRect(with: contentSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedStringKey.font: font], context: nil);
        return rect.size
    }

    /**
     获取字符串宽度
     */
    func width(_ font: UIFont, height: CGFloat = 0) -> CGFloat {
        return size(font, contentSize: CGSize(width: CGFloat(MAXFLOAT), height: height)).width
    }

    /**
     获取字符串高度
     */
    func height(_ font: UIFont, width: CGFloat = 0) -> CGFloat {
        return size(font, contentSize: CGSize(width: width, height: CGFloat(MAXFLOAT))).height
    }
}







