//
//  UserAccount.swift
//  Weibo
//
//  Created by zhangzb on 2017/10/31.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit
import YYModel
//文件存储路径
fileprivate let accountFile:NSString  = "saveAccount.json"
class UserAccount: NSObject {
    //令牌
    @objc var access_token:String?
    //用户代号
    @objc var uid:String?
    //用户昵称
    @objc var screen_name:String?
    //用户头像 大 180*180像素
    @objc var avatar_large:String?
    //过期日期 单位：秒  开发者5年，其他用户3天
    @objc var expires_in:TimeInterval = 0 {
        didSet{
            expitesDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    //过去日期
    @objc var expitesDate:Date?
    
    override var description: String{
        return yy_modelDescription()
    }
    
    override init() {
        super.init()
        //1从本地磁盘加载数据->字典 设置属性值
        guard let path = accountFile.cz_appendDocumentDir(),
              let data = NSData(contentsOfFile: path),
              let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String:AnyObject] else{
                  return
        }
        //2数据设置到模型中    用户是否登录
        yy_modelSet(with: dict ?? [:])
        //判断token是否过期
           //测试过期
           // expitesDate = Date(timeIntervalSinceNow: -3600 * 24)
       if expitesDate?.compare(NSDate() as Date) != .orderedDescending {
           print("账号过期")
           //清空token
           access_token = nil
           uid = nil
           //删除缓存文件
           try? FileManager.default.removeItem(atPath: path)
       }
    
    }
    
    //保存数据 json
    func saveAccount() {
         //1 模型转字典 去掉expires_in
        var dict = (self.yy_modelToJSONObject() as? [String : AnyObject]) ?? [:]
        //移除一个没必要的key
        dict.removeValue(forKey: "expires_in")
        //2 字典序列化
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []),
              let filePath = accountFile.cz_appendDocumentDir()
              else{
              return
        }
        //2 写入磁盘
        (data as NSData).write(toFile: filePath, atomically: true)
        // print("用户保存成功 \(filePath)")
    
    
    

    }


}
