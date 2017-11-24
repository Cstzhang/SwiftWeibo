//
//  ZBEmoticonPackage.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/24.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit
import YYModel
//表情包模型
class ZBEmoticonPackage: NSObject {
    //表情包分组名
    var groupName:String?
    //表情包目录 从目录下加载info.plist可以创建表情模型数组
    var directory:String?{
        didSet{
            //当设置时，从目录下加载info.plist
            guard let directory = directory,
                  let path  = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil),
                  let bundle = Bundle(path: path),
                  let infoPath = bundle.path(forResource: "info.plist", ofType: nil, inDirectory: directory),
                  let array  = NSArray(contentsOfFile: infoPath) as? [[String:String]],
                  let models  = NSArray.yy_modelArray(with: ZBEmoticon.self, json: array) as? [ZBEmoticon]
                else {
                return
            }
         
            print(models)
            //设置表情模型数组
            emoticons += models
            
            
            
            
        }
    }
    //懒加载表情模型数组空数组 (懒加载避免后续解包)
    lazy var emoticons = [ZBEmoticon]()
    
    
    
}
