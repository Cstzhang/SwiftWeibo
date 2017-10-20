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
    //访问令牌，登录除外  2.00aCMggCYa1evD2610494659dtA_UE 2.00aCMggCHdipjB89ce96f2760mSK47
    var accessToken :String? = "2.00aCMggCYa1evD2610494659dtA_UE"
    var uid:String? = "123345"
    /// 封装网络请求
    ///
    /// - Parameters:
    ///   - method: GET / POST
    ///   - URLString: URLString
    ///   - parameters: 参数字典
    ///   - completion: 完成回调[json(字典/数组)，是否成功]
    
    func request(method:HTTPMethod = .GET,URLString:String,parameters:[String:AnyObject]?,completion:@escaping (_ json:AnyObject?,_ isSuccess:Bool)->()) {
        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: { (task, json) in
                completion(json as AnyObject, true)
            }, failure: { (task, error) in
                
                if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                    print("token 过期了")
                    // FIXME: 发送通知 需要登录
                }
                print("网络请求错误\(error)")
                completion(nil, false)
            })
        }else{
            post(URLString, parameters: parameters, progress: nil, success: { (_, json) in
                completion(json as AnyObject, true)
            }, failure: { (task, error) in
                print("网络请求错误\(error)")
                completion(nil, false)
            })
        }
    }
    
    
    // 获取拼接  accessToken
    func tokenRequest(method:HTTPMethod = .GET,URLString:String,parameters:[String:AnyObject]?,completion:@escaping (_ json:AnyObject?,_ isSuccess:Bool)->()) {
        //0,判断toke 是否为nil
        guard let token = accessToken else {
            print("无token,需要登录！")
            // FIXME: 发送通知 需要登录
            completion(nil, false)
            return
        }
        
        //1，判断参数字典是否存在
        var parameters = parameters
        if parameters == nil {
            parameters = [String:AnyObject]()
            
        }
        //2，设置字典参数 parameters一定有值
        parameters!["access_token"] = token as AnyObject

        //3,请求
        request(URLString: URLString, parameters: parameters, completion: completion)
        
    }
   
}

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
