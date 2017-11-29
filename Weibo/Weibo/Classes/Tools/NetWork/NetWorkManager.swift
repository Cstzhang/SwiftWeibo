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
    static let shared = { () -> NetWorkManager in
       //实例化对象
      let instance = NetWorkManager()
      //设置
      instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
      return instance
    }()
    //用户属性
    lazy  var userAccount = UserAccount()
    //计算型属性
    var userlogon: Bool{
        return userAccount.access_token != nil
    }
    
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
                    //发送通知 需要登录
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: "bad token")
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
    
    /// 含有token的网络请求
    ///
    /// - Parameters:
    ///   - method: get/post
    ///   - URLString: url
    ///   - parameters: 参数字典
    ///   - name: 上传文件使用的字段名，默认为nil nil 则不是上传文件
    ///   - data: 上传文件的数据，默认为nil nil则不是上传文件
    ///   - completion: 完成回调
    func tokenRequest(method:HTTPMethod = .GET,URLString:String,parameters:[String:AnyObject]?,name:String? = nil ,data:Data? = nil ,completion:@escaping (_ json:AnyObject?,_ isSuccess:Bool)->()) {
        //0,判断toke 是否为nil 程序执行过程中一般不会为nil
        guard let token = userAccount.access_token else {
            print("无token,需要登录！")
            // 发送通知 需要登录
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
            //回调
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
        
        //3, 判断参数 请求
        if let name = name, let data = data {
            //上传文件
            upload(url: URLString, parameters: parameters, name: name, data: data, completion: completion)
            
        }else{
            //,普通请求
            request(method: method, URLString: URLString, parameters: parameters, completion: completion)
            
        }
        
    }
    //
    
    /// 封装上传文件方法
    ///
    /// - Parameters:
    ///   - url: url
    ///   - parameters: 参数字典
    ///   - name: 服务器接收的数据的字段名 `pic`
    ///   - data: 图片数据
    ///   - completion: 完成回调
    func upload(url:String,parameters:[String:AnyObject]?,name:String,data:Data,completion:@escaping (_ json:AnyObject?,_ isSuccess:Bool)->()) -> () {
        post(url, parameters: parameters, constructingBodyWith: { (formData) in
            //FIXME: -  创建 fromData
            /*
             1,data 要上传的二进制数据
             2,name 服务器接收数据的字段名
             3,fileName 保存在服务器的文件名，大多数服务器上传后生成缩略图，中图，大图
             4，mimeType 上传文件的类型 可以 appliction/octet-stream
                 "image/png image/jpg image/gif"
             */
            
            formData.appendPart(withFileData: data, name: name, fileName: "xxx", mimeType: "application/octet-stream")
            
        }, progress: nil, success: { (_, json) in
            completion(json as AnyObject, true)
        }) { (task, error) in
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                print("token 过期了")
                //发送通知 需要登录
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: "bad token")
            }
            print("网络请求错误\(error)")
            completion(nil, false)
        }

        
    }
    
    
    
   
}

