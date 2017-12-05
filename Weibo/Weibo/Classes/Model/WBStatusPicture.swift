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
    @objc var thumbnail_pic:String?{
        didSet{
            //设置大尺寸图片
            largePic =  thumbnail_pic?.replacingOccurrences(of: "/thumbnail/", with: "/large/")
            
            //更改缩略图地址
            thumbnail_pic =  thumbnail_pic?.replacingOccurrences(of: "/thumbnail/", with: "/wap360/")
        }
    }
    //大尺寸图片
    @objc  var largePic:String?
    
    
    override var description: String{
        return yy_modelDescription()
    }
    
}
