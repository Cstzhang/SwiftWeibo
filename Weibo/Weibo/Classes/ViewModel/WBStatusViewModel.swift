//
//  WBStatusViewModel.swift
//  Weibo
//
//  Created by zhangzb on 2017/11/2.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import Foundation
//单条微博视图模型

//没有继承任何父类 遵守 CustomStringConvertible协议 实现description计算型属性 输出调试信息


class WBStatusViewModel:CustomStringConvertible {
    //微博模型
    var status = WBStatus()
    
    /// 构造函数
    ///
    /// - Parameter model: 微博模型
    init(model:WBStatus) {
        self.status = model
    }
    
    
    var description: String{
        return status.description
    }
    
    
}
