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
    @objc var code:String?{
        didSet{
            guard let code = code else {
                return
            }
            //实例化字符扫描
            let scanner = Scanner(string: code)
            //从code中扫描出16进制的数值
            var result:UInt32 = 0
            scanner.scanHexInt32(&result)
            //使用UInt32 数值，生成一个UTF8字符
            let c  = Character(UnicodeScalar(result)!)
            emoji  = String(c)
        }
    }
    //表情使用次数
    @objc var useTimes:Int = 0
    //emoji的表情字符串
    @objc var emoji:String?
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
     //   print(UIImage(named: "\(directory)/\(png)", in: bundle, compatibleWith: nil))
        return   UIImage(named: "\(directory)/\(png)", in: bundle, compatibleWith: nil)
    }
    
    //当前的图像生成图片的属性文本
    func imageText(font:UIFont) -> NSAttributedString{
        guard let  image = image else{
            return NSAttributedString(string: "")
        }
        let attachment  = ZBEmoticonAttachment()
        //记录图像属性文本
        attachment.chs = chs
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
