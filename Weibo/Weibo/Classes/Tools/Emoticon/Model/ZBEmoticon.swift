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
    @objc  var type = false
    //表情字符串
    @objc var chs:String?
    //表情图片名称
     @objc var png:String?
    //emoji的16进制编码
     @objc var code:String?
    //表情模型所在目录
     @objc var directory:String?
    //·图片·表情对应的图像
     @objc var image:UIImage?{
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
        print(UIImage(named: "\(directory)/\(png)", in: bundle, compatibleWith: nil))
        return   UIImage(named: "\(directory)/\(png)", in: bundle, compatibleWith: nil)
    }
    
    //当前的图像生成图片的属性文本
    func imageText(font:UIFont) -> NSAttributedString{
        guard let  image = image else{
            return NSAttributedString(string: "")
        }
        let attachment  = NSTextAttachment()
        attachment.image = image
        let  height = font.lineHeight
        attachment.bounds = CGRect(x: 0, y: -4, width: height, height: height)
        // 3. 返回图片属性文本
        let attrStrM = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
        // 设置字体属性
        attrStrM.addAttributes([NSAttributedStringKey.font: font], range: NSRange(location: 0, length: 1))
        
        return attrStrM
    }
    override  var description: String{
        return yy_modelDescription()
    }
    
    
   
    
    
    
}
