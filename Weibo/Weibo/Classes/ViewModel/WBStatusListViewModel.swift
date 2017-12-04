//
//  WBStatusListViewModel.swift
//  Weibo
//
//  Created by zhangzb on 2017/10/20.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import Foundation
import SDWebImage
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
          //数据访问层加载数据
          WBStatusListDAL.loadStatus(since_id: since_id,max_id: max_id) { (list, isSuccess) in
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
           // print("获取\(array.count)条数据 \(array)")
            
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
                //缓存单张图片
                self.cacheSingleImage(list: array,finished:completion)
            }
            
        
         
            
        }
        
    }
    
    
    /// 缓存微博中的单张图片
    /// 缓存完单张图片，并且修改配图视图的大小后回调，才能保证表格等比例显示单张图片
    /// - Parameter list: 视图模型数组
    private func cacheSingleImage(list:[WBStatusViewModel],finished:@escaping (_ success:Bool,_ shouldRefresh:Bool)->())  {
        // 1 创建调度组
        let group  = DispatchGroup()
        //图片数据长度
        var length = 0
        //拿到图片url
        for vm in list {
            //判断图片数量
            if vm.picURLs?.count != 1{
                continue
            }
            //获取URL 代码走到这，数组中有且只有1张图片
           guard let pic  = vm.picURLs?[0].thumbnail_pic ,
                 let url = URL(string: pic) else{
                
                continue
            }
          //  print("要缓存的url : \(url)")
            
            //下载图片 下载完成后图片会自动保存到沙河中 路径是 url 的 MD5
            // 如果沙河中已经有图片，通过SD加载图片，会加载沙河中的图片 不发起网络请求，回调方法同样会调用
            // 缓存完成后更新 视图模型尺寸
            // 加入调度组
            group.enter()
            
            SDWebImageManager.shared().imageDownloader?.downloadImage(with: url, options: [], progress: nil, completed: { (image, _, _, _) in
                //图片转换成2进制数据
                if let image = image,
                    let data  = UIImagePNGRepresentation(image){
                    length += data.count
                    //图片缓存成功，更新视图大小
                    vm.updateSingleImageSize(image: image)
                }
              //  print("缓存的图片 \(String(describing: image)) 长度\(length)")
                
                //出调度组
                group.leave()
            });

        }
        //调度组完成
        group.notify(queue: DispatchQueue.main) {
           //图像缓存完成
           // print("缓存文件大小: \(length / 1024)k")
            //3,完成回调,刷新表格
            finished(true, true)
        }
        
        
    }
    
    
    
}
