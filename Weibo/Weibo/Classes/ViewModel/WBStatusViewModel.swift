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
/*
1,尽量少计算，所有需要显示的控件提前准备好
2，控件上不要设置设置圆角半径，所有的图像渲染的属性要注意
3，不要动态创建控件，要体检创建好，在显示的时候判断 隐藏还是显示
4，cell中控件的层次越少越好
 
 */



class WBStatusViewModel:CustomStringConvertible {
    //微博模型
    var status = WBStatus()
    var memberIcon:UIImage?
    /// 构造函数
    ///
    /// - Parameter model: 微博模型
    init(model:WBStatus) {
        self.status = model
        if (model.user?.mbrank)! > 0 && ((model.user?.mbrank))! < 7{
            let imageName = "common_icon_membership_level\(model.user?.mbrank ?? 1)"
            memberIcon = UIImage(named: imageName)
        }
//        else{
//            let imageName = "common_icon_membership_expired"
//            memberIcon = UIImage(named: imageName)
//
//        }
    }
    
    
    var description: String{
        return status.description
    }
    
    
}
