//
//  WBNetWorkManager+Extension.swift
//  Weibo
//
//  Created by zhangzb on 2017/10/18.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import Foundation
// MARK: -封装新浪微博的网络请求

extension NetWorkManager{
    
    /// 加载微博数据
    ///
    /// - Parameters:
    ///   - since_id: 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
    ///   - max_id: 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
    ///   - Parameter completion: 完成回调[list:微博字典数组，是否成功]
    func statusList(since_id:Int64 = 0,max_id:Int64 = 0,completion:@escaping (_ list:[[String:AnyObject]]?,_ isSuccess:Bool)->())  {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        // int 可以转anobject int64不行
        let params = ["since_id":"\(since_id)","max_id":"\(max_id > 0 ? max_id-1 : 0 )"]
        tokenRequest(URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            //从json中获取statuses数据 如果as 失败 result = nil
            let result = json?["statuses"] as? [[String:AnyObject]]
            completion(result, isSuccess)
        }

    }
    
    /// 微博的未读数量
    ///
    /// - Returns:
    func unreadCount(completion:@escaping (_ count:Int)->()) {
        guard let uid = userAccount.uid else {
            return
        }
        let urlString = "https://rm.api.weibo.com/2/remind/unread_count.json"
        let params = ["uid":uid]
        tokenRequest(URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
//            print(json ?? "")
            let dic = json as? [String : AnyObject]
            let count = dic?["status"] as? Int
            completion(count ?? 0)
        }
        
    }
}
// MARK: -用户信息
extension NetWorkManager{
    //加载用户信息 登录后执行
    func loadUserInfo(completion:@escaping (_ dict:[String:AnyObject])->())  {
        guard let _ = userAccount.uid else {
            return
        }
        let urlString = "https://api.weibo.com/2/users/show.json"
        let params = ["uid":userAccount.uid]
        //发起网络请求
        tokenRequest(URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
//            print(json ?? "")
            
            completion((json as? [String : AnyObject]) ?? [:])
            
            
            
        }
        
    }
    
}


extension NetWorkManager {
    //异步网络请求
    
    /// 获取授权码
    ///
    /// - Parameters:
    ///   - code: 授权码
    ///   - comletion: 完成回调 是否成功
    func loadAccessToken(code: String,comletion:@escaping (_ isSuccess:Bool)->()){
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let params = ["client_id":WBAppKey,
                      "client_secret":WBAppSecret,
                      "grant_type":"authorization_code",
                      "code":code,
                      "redirect_uri":WBRedirectURL]
        //发起网络请求
        request(method:.POST, URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            //如果请求失败，对用户账户失败不会有影响
            //设置UserAccount属性
            self.userAccount.yy_modelSet(with: (json as? [AnyHashable : Any]) ?? [:] )
            //加载当前用户信息
            self.loadUserInfo(completion: { (dict) in
//                print(dict)
                //使用用户信息字典设置用户账户信息（昵称 头像）
                self.userAccount.yy_modelSet(with: dict)
                //保存
                self.userAccount.saveAccount()
                //用户信息加载完成 再完成回调
                comletion(isSuccess)
            })
         
        }
        
    }
    
    
    
}


