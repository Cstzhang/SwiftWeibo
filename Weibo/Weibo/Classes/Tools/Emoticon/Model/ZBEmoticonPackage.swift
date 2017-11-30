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
     @objc var groupName:String?
    // 背景图名称
    @objc var  bgImageName:String?
    //表情包目录 从目录下加载可以创建表情模型数组
    @objc  var directory:String?{
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

            //print(models)
            //遍历models 设置目录
            for m in models {
                m.directory = directory
            }
            //设置表情模型数组
            emoticons += models
        }
    }
    //懒加载表情模型数组空数组 (懒加载避免后续解包)
    @objc  lazy var emoticons = [ZBEmoticon]()
    var numberOfPages:Int{
        return (emoticons.count - 1)  / 20 + 1
    }
    //从懒加载的表情包中，按照page截取最多20个表情模型的数组（假设26表情）
    //page=0 返回0~19模型，
    //page=1 返回20~25模型
    func emotico(page:Int) -> [ZBEmoticon] {
        //每页最多表情数
        let count  = 20
        let location = page * count
        var length  = count
        //判断数据是否超出
        if location + length > emoticons.count {
            length = emoticons.count - location
        }
        let range  = NSRange(location:location, length: length)
        //截取数组的子数组
        let subArray =   (emoticons as NSArray).subarray(with: range)
        return subArray as! [ZBEmoticon]
    }
    
    override var description: String {
        return yy_modelDescription()
    }
    
    
}
