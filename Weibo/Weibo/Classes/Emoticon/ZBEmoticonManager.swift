//
//  ZBEmoticonManager.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/24.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import Foundation

//表情管理器
class ZBEmoticonManager {
    //表情管理器单例
    static let shared = ZBEmoticonManager()
    lazy var packages = [ZBEmoticonPackage]()
    //构造函数 在init之前增加 private修饰符,可以要求调用者必须用shared访问对象
    //oc 中要重写 allocWithZone
    private init() {
        loadPackages()
    }
    
}


//表情包数据处理
private extension ZBEmoticonManager{
    func loadPackages() -> () {
        //数据路径 按照Bundle默认的路径的目录读取，就能获取到Resource目录下文件
        guard let path  = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil),
              let bundle  = Bundle(path: path),
              let plistPath = bundle.path(forResource: "emoticons.plist", ofType: nil),
              let array = NSArray(contentsOfFile: plistPath) as? [[String:String]],
              let models = NSArray.yy_modelArray(with: ZBEmoticonPackage.self, json: array) as? [ZBEmoticonPackage]
              else{
              return
        }
        //设置表情包数据 +=不会覆盖之前的懒加载的空间，直接追加数据
        packages += models
       
        print(packages)
        
    }
    
    
    
}
