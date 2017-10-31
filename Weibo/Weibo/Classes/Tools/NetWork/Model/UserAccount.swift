//
//  UserAccount.swift
//  Weibo
//
//  Created by zhangzb on 2017/10/31.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

class UserAccount: NSObject {
    //令牌
    var access_token:String? 
    //用户代号
    var uid:String?
    //过期日期 单位：秒  开发者5年，其他用户3天
    var expires_in:TimeInterval = 0
    
    override var description: String{
        return yy_modelDescription()
    }
    
    

}
