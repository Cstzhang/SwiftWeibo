//
//  WBStatus.swift
//  Weibo
//
//  Created by zhangzb on 2017/10/20.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit
import YYModel
//新浪数据模型
class WBStatus: NSObject {
  //微博ID int类型在ipad2 iphone 5 /5c/4s/4 这些32位机器都无法正常使用 会溢出
  @objc  var id:Int64 = 0
  //微博信息
  @objc  var text:String?
  //转发数
  @objc  var reposts_count:Int = 0
  // 评论数
  @objc  var comment_count:Int = 0
  //点赞数
  @objc  var attitudes_count:Int = 0
  //微博用户
  @objc  var user:WBUser?
    
    //重写 description的计算型属性
    override var description: String{
        return yy_modelDescription()
    }
    

}
