//
//  ZBEmoticon.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/24.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit
import YYModel
//表情模型
class ZBEmoticon: NSObject {
    //表情类型 false 是图片 true是emoji
    var type = false
    //表情字符串
    var chs:String?
    //表情图片名称
    var png:String?
    //emoji的16进制编码
    var code:String?
    //表情模型所在目录
    var directory:String?
    //·图片·表情对应的图像
    var image:UIImage?{
        //判断表情类型
        if type {
            return nil
        }
        guard let directory = directory,
              let png = png,
              let path  = Bundle.main.path(forResource: "HMEmoticon.bundle", ofType: nil),
              let bundle = Bundle(path: path) else{
              return nil
        }
        return   UIImage(named: "\(directory)/\(png)", in: bundle, compatibleWith: nil)

    }

     override  var description: String{
        return yy_modelDescription()
    }
    
    
    
}
