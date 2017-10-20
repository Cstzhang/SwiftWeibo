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
        let params = ["since_id":"\(since_id)","max_id":"\(max_id)"]
        tokenRequest(URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            //从json中获取statuses数据 如果as 失败 result = nil
            let result = json?["statuses"] as? [[String:AnyObject]]
            completion(result, isSuccess)
        }

    }
}

