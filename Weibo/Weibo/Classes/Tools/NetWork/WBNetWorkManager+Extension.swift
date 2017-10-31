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
        let urlString = "https://api.weibo.com/2/statuses/user_timeline.json"
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
            print(json ?? "")
            let dic = json as? [String : AnyObject]
            let count = dic?["status"] as? Int
            completion(count ?? 0)
        }
        
    }
}

extension NetWorkManager {
    func loadAccessToken(code: String){
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let params = ["client_id":WBAppKey,
                      "client_secret":WBAppSecret,
                      "grant_type":"authorization_code",
                      "code":code,
                      "redirect_uri":WBRedirectURL]
        //发起网络请求
        request(method:.POST, URLString: urlString, parameters: params as [String : AnyObject]) { (json, success) in
            print(json ?? "")
            //设置UserAccount属性
            self.userAccount.yy_modelSet(with: (json as? [AnyHashable : Any]) ?? [:] )
            print(self.userAccount)
            //保存
            self.userAccount.saveAccount()
        }
        
    }
    
    
    
}


