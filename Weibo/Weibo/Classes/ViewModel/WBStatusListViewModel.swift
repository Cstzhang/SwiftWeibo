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
//上拉刷新最大尝试次数
fileprivate let maxPullupTryTimes = 3
//微博数据列表视图模型
class WBStatusListViewModel {
    //微博视图模型数组懒加载
    lazy var statusList = [WBStatusViewModel]()
    //上拉刷新错误次数
    fileprivate var pullErrorTimes = 0
    
    /// 加载微博列表
    ///
    /// - Parameters:
    ///   - pullop: 是否上拉刷新
    ///   - Parameter completion:完成回调，网络请求是否成功
    func loadStatus(pullop:Bool  ,completion:@escaping (_ success:Bool,_ shouldRefresh:Bool)->())  {
        //判断是否是上拉刷新
        if pullop && pullErrorTimes > maxPullupTryTimes{
            completion(false,false)
            return
        }
        //since_id 下拉 数组中第一条微博id pullop是否上拉刷新
        let since_id = pullop ? 0 : (statusList.first?.status.id ?? 0)
        //max_id 上拉 数组中最后条微博id
        let max_id = !pullop ? 0 :(statusList.last?.status.id ?? 0)
          //网络请求 加载数据
          NetWorkManager.shared.statusList(since_id: since_id,max_id: max_id) { (list, isSuccess) in
           //0 判断网络请求是否成功
            if !isSuccess{
                completion(false, false)
                return
            }
            
            var array = [WBStatusViewModel]()
            //FIX ME
            //便利字典数组 字典转模型
            for dict  in list ?? []{
                //创建微博模型 创建失败，继续后续的遍历
                guard let model = WBStatus.yy_model(with: dict) else{
                    continue
                }
                //model 添加到数组
                array.append(WBStatusViewModel(model: model))
                
            }
            
         //2,拼接数据
            print("获取\(array.count)条数据 \(array)")
            //下拉刷新，应该将数组拼接在前面
            if pullop {//上拉刷新
                self.statusList += array
            }else{//下拉刷新
                self.statusList = array + self.statusList
                
            }
           //判断上拉刷新数据量
            if pullop && array.count == 0{
                self.pullErrorTimes += 1
                completion(isSuccess, false)
            }else{
                //3,完成回调
                completion(isSuccess,true)
                
            }
            
        
         
            
        }
        
    }
    
    
    
}
