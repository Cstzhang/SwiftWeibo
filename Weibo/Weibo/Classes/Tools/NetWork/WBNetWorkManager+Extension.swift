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
    /// - Parameter completion: 完成回调[list:微博字典数组，是否成功]
    func statusList(completion:@escaping (_ list:[[String:AnyObject]]?,_ isSuccess:Bool)->())  {
        let urlString = "https://api.weibo.com/2/statuses/user_timeline.json"
        tokenRequest(URLString: urlString, parameters: nil) { (json, isSuccess) in
            //从json中获取statuses数据 如果as 失败 result = nil
            let result = json?["statuses"] as? [[String:AnyObject]]
            completion(result, isSuccess)
        }

    }
}

