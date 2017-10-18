//
//  NetWorkManager.swift
//  Weibo
//
//  Created by zhangzb on 2017/10/18.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit
import AFNetworking

//Swit 枚举支持任意数据类型
enum HTTPMethod {
    case GET
    case POST
}


// MARK: -网络管理工具
class NetWorkManager: AFHTTPSessionManager {
    //静态-常量-闭包（第一次访问时执行闭包，并且保存在shared常量中） 单例
    static let shared = NetWorkManager()
// WARN: - 后期需要优化
    /// 封装网络请求
    ///
    /// - Parameters:
    ///   - method: GET / POST
    ///   - URLString: URLString
    ///   - parameters: 参数字典
    ///   - completion: 完成回调[json(字典/数组)，是否成功]
    func request(method:HTTPMethod = .GET,URLString:String,parameters:[String:AnyObject],completion:@escaping (_ json:AnyObject?,_ isSuccess:Bool)->()) {
        print("准备网络请求")
//        //成功回调
//        let success   = {(task:URLSessionDataTask,json:AnyObject?)-> Void in
//            print("网络请求成功")
//            completion(json, true)
//        }
//        //失败回调
//        let failure = { (task:URLSessionDataTask?,error:NSError)-> Void in
//            print("网络请求错误\(error)")
//            completion(nil, false)
//        }
        
        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: { (_, json) in
                completion(json as AnyObject, true)
            }, failure: { (_, error) in
                print("网络请求错误\(error)")
                completion(nil, false)
            })
                //                success: success as? (URLSessionDataTask, Any?) -> Void,
                //                failure: failure as? (URLSessionDataTask?, Error) -> Void)
//            get(<#T##URLString: String##String#>, parameters: <#T##Any?#>, progress: <#T##((Progress) -> Void)?##((Progress) -> Void)?##(Progress) -> Void#>, success: <#T##((URLSessionDataTask, Any?) -> Void)?##((URLSessionDataTask, Any?) -> Void)?##(URLSessionDataTask, Any?) -> Void#>, failure: <#T##((URLSessionDataTask?, Error) -> Void)?##((URLSessionDataTask?, Error) -> Void)?##(URLSessionDataTask?, Error) -> Void#>)
//          get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
//
            
        }else{
            post(URLString, parameters: parameters, progress: nil, success: { (_, json) in
                completion(json as AnyObject, true)
            }, failure: { (_, error) in
                print("网络请求错误\(error)")
                completion(nil, false)
            })
        }
        
        
        
        
    }
   
}
