//
//  WBStatusListDAL.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/12/4.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import Foundation
// DAL data access layer 数据访问层
// 负责处理数据库和网络数据，给listViewModel 返回微博数据
class WBStatusListDAL {
    
    /// 从本地数据库/网络加载数据
    ///
    /// - Parameters:
    ///   - since_id: 下拉刷新ID
    ///   - max_id: 上拉刷新ID
    ///   - completion: 完成回调（微博数组，是否成功）
    class func loadStatus(since_id:Int64 = 0,max_id:Int64 = 0,completion:@escaping (_ list:[[String:AnyObject]]?,_ isSuccess:Bool)->()){
        // 0 用户userid
        guard let userId  = NetWorkManager.shared.userAccount.uid else{
            return
        }
        // 1检查本地是否有数据，有返回
        let array = ZBSQLiteManager.shared.loadStatus(userId: userId, since_id: since_id, max_id: max_id)
            //判断array 是否有返回数据
        if array.count > 0 {
            completion(array, true)
            return
        }
        // 2加载网络数据
        NetWorkManager.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            if !isSuccess{//判断网络是否成功
                completion(nil, false)
                return
            }
            guard let list = list else{
                completion(nil, isSuccess)
                return
            }
           // 3网络数据加载完成后写入本地数据库
            ZBSQLiteManager.shared.updateStatus(userId: userId, array: list)
            
            // 4返回网络数据
            completion(list , isSuccess)
        }
    }
}
