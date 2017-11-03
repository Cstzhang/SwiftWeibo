//
//  WBStatusPicture.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/3.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit
import YYModel
//微博配图模型
class WBStatusPicture: NSObject {
    //微博图片
    var thumbnail_pic:String?
    
    override var description: String{
        return yy_modelDescription()
    }
    
}
