//
//  Date+LTExtension.swift
//  LTExtensionDemo
//
//  Created by TopSky on 2018/3/31.
//  Copyright © 2018年 TopSky. All rights reserved.
//

import Foundation

public extension Date {

    /**
     时间单位转换为秒
     */
    struct ConvertTimeInterval {
        static let day: TimeInterval = 86400
        static let hour: TimeInterval = 3600
        static let minute: TimeInterval = 60
    }

    /**
     时间转换常用Format
     */
    struct ConvertTimeFormat {
        static let enYearToSecond: String = "yyyy-MM-dd HH:mm:ss"
        static let enYearToDay: String = "yyyy-MM-dd"
        static let cnYearToSecond: String = "yyyy年MM月dd日 HH:mm:ss"
        static let cnYearToDay: String = "yyyy年MM月dd日"
    }

    /**
     月份数组
     */
    static let monthArray: [String] = ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"]

    /**
     时间数组
     */
    static let weekArray: [String] = ["星期一","星期二","星期三","星期四","星期五","星期六","星期日"]


    /**
     获取-年
     */
    var year: Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year], from: self)
        return com.year.safeValue
    }

    /**
     获取中国年份
     */
    var cnYear: String {
        return "\(year)年"
    }


    /**
     获取-月
     */
    var month: Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year, .month], from: self)
        return com.month.safeValue
    }

    /**
     获取中国月份
     */
    var cnMonth: String {
        return Date.convertMonth(month)
    }

    /**
     获取-日
     */
    var day: Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year, .month, .day], from: self)
        return com.day.safeValue
    }

    /**
     获取中国日
     */
    var cnDay: String {
        return "\(day)日"
    }

    /**
     获取-周几
     */
    var weekDay: Int {
        let interval = Int(timeIntervalSince1970) + NSTimeZone.local.secondsFromGMT()
        let days = Int(interval/Int(ConvertTimeInterval.day))
        let weekday = ((days + 4)%7+7)%7
        return weekday == 0 ? 7 : weekday
    }

    /**
     获取中国星期
     */
    var cnWeekDay: String {
        return Date.convertWeek(weekDay)
    }

    /**
     获取- 月份天数
     */
    var daysInMonth: Int {
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self)
        return (range?.length).safeValue
    }

    /**
     是否是今天
     */
    var isToday: Bool {
        let calendar = NSCalendar.current
        let lhs = calendar.dateComponents([.year,.month,.day], from: self)
        let rhs = calendar.dateComponents([.year,.month,.day], from: Date())
        return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
    }

    /**
     获取倒计时
     */
    var countdownTime: (days: Int, hours: Int, minutes: Int, second: Int) {
        let timeInterval = timeIntervalSinceNow - Date().timeIntervalSinceNow
        return Date.convert(timeInterval)
    }

    /**
     获取经过时间
     */
    var passTime: String {
        let timeInterval = abs(timeIntervalSinceNow - Date().timeIntervalSinceNow)
        let pass = Date.convert(timeInterval)
        guard pass.days < 30 else {
            return convert(dateFormat: ConvertTimeFormat.enYearToDay)
        }
        guard pass.days < 1 else {
            return "\(pass.days)天前"
        }
        guard pass.hours < 1 else {
            return "\(pass.hours)小时前"
        }
        guard pass.minutes < 1 else {
            return "\(pass.minutes)分钟前"
        }
        return "刚刚"
    }


    /**
     日期转字符串
     */
    func convert(dateFormat: String) -> String{
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: self)
        return date
    }


    /**
     根据时间戳 和日期格式
     获取 字符串日期
     */
    static func convert(timeInterval: TimeInterval, dateFormat: String) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = dateFormat
        let result = formatter.string(from: date)
        return result
    }

    /**
     月份转换
     */
    static func convertMonth(_ index: Int) -> String {
        return Date.monthArray.safe(index: index - 1).safeValue
    }

    /**
     星期转换
     */
    static func convertWeek(_ index: Int) -> String {
        return Date.weekArray.safe(index: index - 1).safeValue
    }


    /**
     时间戳 转为 剩余时间形式
     */
    static func convert(_ timeInterval: TimeInterval) -> (days: Int, hours: Int, minutes: Int, second: Int) {
        let days = Int(timeInterval/ConvertTimeInterval.day)
        let hours = Int((timeInterval - ConvertTimeInterval.day*Double(days))/ConvertTimeInterval.hour)
        let minutes = Int((timeInterval - ConvertTimeInterval.day*Double(days) - ConvertTimeInterval.hour*Double(hours))/ConvertTimeInterval.minute)
        let seconds = Int(timeInterval - ConvertTimeInterval.day*Double(days) - ConvertTimeInterval.hour*Double(hours) -
            ConvertTimeInterval.minute*Double(minutes)
            )
        return (days, hours, minutes, seconds)
    }


    /**
     每个月的第一天是周几
     */
    static func firstWeekDay(year: Int, month: Int) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let date = dateFormatter.date(from: "\(year)-\(month)")
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let comps = (calendar as NSCalendar?)?.components(NSCalendar.Unit.weekday, from: date!)
        let week = comps?.weekday
        let result = week! - 1
        return result == 0 ? 7 : result
    }

}



