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

     override  var description: String{
        return yy_modelDescription()
    }
    
    
    
}
