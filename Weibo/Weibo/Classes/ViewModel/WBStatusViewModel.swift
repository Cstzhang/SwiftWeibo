//
//  WBStatusViewModel.swift
//  Weibo
//
//  Created by zhangzb on 2017/11/2.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import Foundation
//单条微博视图模型
class WBStatusViewModel {
    //微博模型
    var status = WBStatus()
    
    /// 构造函数
    ///
    /// - Parameter model: 微博模型
    init(model:WBStatus) {
        self.status = model
    }
    
    
    
    
}
