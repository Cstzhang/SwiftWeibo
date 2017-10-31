//
//  UserAccount.swift
//  Weibo
//
//  Created by zhangzb on 2017/10/31.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit
import YYModel
class UserAccount: NSObject {
    //令牌
   @objc var access_token:String?
    //用户代号
   @objc  var uid:String?
    //过期日期 单位：秒  开发者5年，其他用户3天
   @objc  var expires_in:TimeInterval = 0 {
        didSet{
            expitesDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    //过去日期
   @objc  var expitesDate:Date?
    
    override var description: String{
        return yy_modelDescription()
    }
    
    //保存数据 json
    func saveAccount() {
         //1 模型转字典 去掉expires_in
        var dict = (self.yy_modelToJSONObject() as? [String : AnyObject]) ?? [:]
        
        dict.removeValue(forKey: "expires_in")
        //2 字典序列化
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []),
              let filePath = ("saveAccount.json" as NSString).cz_appendDocumentDir()
              else{
              return
        }
        //2 写入磁盘
        (data as NSData).write(toFile: filePath, atomically: true)
         print("用户保存成功 \(filePath)")

    }


}
