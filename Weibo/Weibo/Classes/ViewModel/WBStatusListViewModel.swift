//
//  WBStatusListViewModel.swift
//  Weibo
//
//  Created by zhangzb on 2017/10/20.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import Foundation
/*
 父类的选择
 - 如果类需要时用"KVC"或者字典模型框架设置对象值，类就需要继承NSObject
 - 如果类知识包装一些代码逻辑（写一些函数）,可以不用任何父类：更轻量级
 - OC 一律继承NSObject
 */


//微博数据列表视图模型
class WBStatusListViewModel {
    //微博模型数组懒加载
    lazy var statusList = [WBStatus]()
    
    
    /// 加载微博列表
    ///
    /// - Parameter completion:完成回调，网络请求是否成功
    func loadStatus(completion:@escaping (_ success:Bool)->())  {
          NetWorkManager.shared.statusList { (list, isSuccess) in
          //1,字典转模型
             guard  let array = NSArray.yy_modelArray(with: WBStatus.self, json: list ?? []) as? [WBStatus] else{
                completion(isSuccess)
                return
            }
         //2,拼接数据
            self.statusList += array
         //3,完成回调
            completion(isSuccess)
            
        }
        
    }
    
    
    
}
