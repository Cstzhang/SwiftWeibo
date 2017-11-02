//
//  WBUser.swift
//  Weibo
//
//  Created by zhangzb on 2017/11/2.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit
import YYModel
//微博用户模型
class WBUser: NSObject {
    // 基本数据类型和privte 不能使用kvc设置
   @objc var id:Int64 = 0
    //昵称
   @objc var screen_name:String?
    //头像  50*50
   @objc var profile_image_url:String?
    //认证 -1未认证  0 认证 234 企业认证 220 达人
   @objc var verified_type:Int = 0
    //会员等级 0-6
   @objc var mbrank:Int = 0
    
  override var description: String{
        return yy_modelDescription()
        
  }
    
    
    
    
    
    

}
