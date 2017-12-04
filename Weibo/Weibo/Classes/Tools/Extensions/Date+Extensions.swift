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
extension Date{
    //计算当前系统时间偏差，delta 描述的日期字符串
    //在Swift 中，定义结构体的类函数，用 static修饰，静态函数
    static func zb_dateString(delta:TimeInterval) -> String {
        let date  = Date(timeIntervalSinceNow: delta)
        //指定日期格式
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
}
