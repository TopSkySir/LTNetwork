//
//  NSAttributedString+Extension.swift
//  LTExtensionDemo
//
//  Created by TopSky on 2018/2/27.
//  Copyright © 2018年 TopSky. All rights reserved.
//

import Foundation
import UIKit

open class NSAttributedContent: NSObject {

    /**
     字号
     */
    open var font: UIFont?

    /**
     段落格式
     */
    open var paragraphStyle: NSParagraphStyle?

    /**
     字体颜色
     */
    open var foregroundColor: UIColor?

    /**
     背景颜色
     */
    open var backgroundColor: UIColor?

    /**
     是否 使用 连接字符 默认值： 1
     0: 不使用
     1: 默认连接子符
     */
    open var ligature: Int?

    /**
     字间距 浮点 默认值： 0
     0: 不使用字母紧排
     */
    open var kern: CGFloat?

    /**
     删除线
     */
    open var strikethroughStyle:  NSUnderlineStyle?

    /**
     删除线颜色
     */
    open var strikethroughColor: UIColor?

    /**
     下划线
     */
    open var underlineStyle: NSUnderlineStyle?

    /**
     下划线颜色
     */
    open var underlineColor: UIColor?

    /**
     填充颜色
     */
    open var strokeColor: UIColor?
    /** 描边宽度 默认值： 0
     负值填充， 正值中空
     */
    open var strokeWidth: CGFloat?

    /**
     阴影
     */
    open var shadow: NSShadow?

    /**
     文字特殊效果 目前只有图版印刷效果可用
     */
    open var textEffect: NSAttributedString.TextEffectStyle?

    /**
     文本附件
     */
    open var attachment: NSTextAttachment?

    /**
     文本链接
     */
    open var link: NSString?

    /**
     文本基准线 默认值： 0
     正值： 上偏
     负值： 下偏
     */
    open var baselineOffset: CGFloat?

    /**
     倾斜度 默认值 0
     正值： 右倾
     负值： 左倾
     */
    open var obliqueness: CGFloat?


    /**
     扁平化
     */
    open var expansion: CGFloat?

    /**
     书写方向
     0: LRE
     1: RLE
     2: LRO
     3: RLO
     */
    open var writingDirection: Int?

    /**
     排版方向 默认0 Currently on iOS, it's always horizontal.
     0: 水平排版
     1: 垂直排版
     */
    open var verticalGlyphForm: Int?

    /**
     容器属性映射字典 content convert to Dictionary
     */
    open func toDictionary() -> [NSAttributedStringKey: Any] {
        var dict = [NSAttributedStringKey: Any]()
        dict[.font] = font
        dict[.paragraphStyle] = paragraphStyle
        dict[.foregroundColor] = foregroundColor
        dict[.backgroundColor] = backgroundColor
        dict[.ligature] = ligature
        dict[.kern] = kern
        dict[.strikethroughStyle] = strikethroughStyle?.rawValue
        dict[.strikethroughColor] = strikethroughColor
        dict[.underlineStyle] = underlineStyle?.rawValue
        dict[.underlineColor] = underlineColor
        dict[.strokeColor] = strokeColor
        dict[.strokeWidth] = strokeWidth
        dict[.shadow] = shadow
        dict[.textEffect] = textEffect
        dict[.attachment] = attachment
        dict[.link] = link
        dict[.baselineOffset] = baselineOffset
        dict[.obliqueness] = obliqueness
        dict[.expansion] = expansion
        if let writingDirection = writingDirection {
            dict[.writingDirection] = [writingDirection]
        }
        dict[.verticalGlyphForm] = verticalGlyphForm
        return dict
    }

}

public extension NSAttributedString {

    /**
     拼接 字符串 和 属性
     string: 拼接内容
     dict: 描述属性
     */
    func append(_ string: String, _ dict: [NSAttributedStringKey: Any]?) -> NSAttributedString {
        let lhs = NSMutableAttributedString(attributedString: self)
        let rhs = NSAttributedString(string: string, attributes: dict)
        lhs.append(rhs)
        return lhs
    }

    /**
     拼接属性 在原有的基础上
     dict: 描述属性
     */
    func append(_ dict: [NSAttributedStringKey: Any]) -> NSAttributedString {
        let lhs = NSMutableAttributedString(attributedString: self)
        let range = NSRange(location: 0, length: self.string.count)
        lhs.addAttributes(dict, range: range)
        return lhs
    }


    /**
     拼接 字符串 和 属性
     string: 拼接内容
     closure: 描述属性l闭包 可增加修改属性
     */
    func append(_ string: String, _ closure: (NSAttributedContent) -> Void) -> NSAttributedString {
        let content = NSAttributedContent()
        closure(content)
        let dict = getAttributedDictionay(content)
        return self.append(string, dict).appendAttachment(content.attachment)
    }

    /**
     拼接属性 在原有的基础上
     closure: 描述属性闭包 可增加修改属性
     */
    func append(_ closure: (NSAttributedContent) -> Void) -> NSAttributedString {
        let content = NSAttributedContent()
        closure(content)
        let dict = getAttributedDictionay(content)
        return self.append(dict).appendAttachment(content.attachment)
    }

    /**
     拼接附件
     */
    func appendAttachment(_ attachment: NSTextAttachment?) -> NSAttributedString {
        guard let resultAttachment = attachment else {
            return self
        }
        let lhs = NSMutableAttributedString(attributedString: self)
        let rhs = NSAttributedString(attachment: resultAttachment)
        lhs.append(rhs)
        return lhs
    }


    /**
     容器属性映射字典 content convert to Dictionary
     */
    fileprivate func getAttributedDictionay(_ content: NSAttributedContent) -> [NSAttributedStringKey: Any] {
        var dict = content.toDictionary()
        /**
         忽略附件
         */
        dict[.attachment] = nil
        return dict
    }


    /**
     拼接
     */
    func appendDeleteLine(_ style: NSUnderlineStyle = NSUnderlineStyle.styleSingle, _ color: UIColor? = nil) -> NSAttributedString {
        let closure: (NSAttributedContent) -> Void = { (content) in
            content.strikethroughStyle = style
            content.strikethroughColor = color
        }
        return self.append(closure)
    }

    
}
