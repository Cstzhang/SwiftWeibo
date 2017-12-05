//
//  Date+Extensions.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/12/4.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import Foundation
//格式转化器
private let dateFormatter = DateFormatter()
//当前日历对象
private let calendar   = Calendar.current

extension Date{
    //计算当前系统时间偏差，delta 描述的日期字符串
    //在Swift 中，定义结构体的类函数，用 static修饰，静态函数
    static func zb_dateString(delta:TimeInterval) -> String {
        let date  = Date(timeIntervalSinceNow: delta)
        //指定日期格式
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    
    /// 新浪格式的字符串转换成日期
    ///
    /// - Parameter string: 新浪日期字符串
    /// - Returns: 日期
    static func zb_sinaDate(string:String)->Date?{
        //设置日期格式
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
        //转换返回日期
        return dateFormatter.date(from: string)
        
        
    }
    
    
    /// 日历时间
    var zb_dateDescription:String{
        //判断日期是否是今天
        if calendar.isDateInToday(self) {
            let delta = self.timeIntervalSinceNow
            if delta < 60 {
                return "刚刚"
            }
            if delta < 3600 {
                return "\(delta / 60)分钟前"
            }
                return "\(delta / 3600)小时前"
        }
        var fmt  = " HH:mm"
        if calendar.isDateInYesterday(self) {
            fmt = "昨天" + fmt
        }else{
             fmt = "MM-dd" + fmt
            let year  = calendar.component(.year, from: self)
            let thisYear = calendar.component(.year, from: Date())
            if thisYear != year {
               fmt = "yyyy-" + fmt
            }
        }
        dateFormatter.dateFormat = fmt
        return dateFormatter.string(from: self)
    }
    
    
}
