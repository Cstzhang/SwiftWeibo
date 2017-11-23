//
//  String+Extensions.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/23.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import Foundation
extension String{
    //从当前字符串中提取链接/文本
    func zb_href() -> () {
        //0 匹配方案 "<a href="http://app.weibo.com/t/feed/6vtZb0" rel="nofollow">微博 weibo.com</a>"
        let pattern  = "<a href=\"(.*?)\".*?>(.*?)</a>"
        //1正则
        guard  let regx = try? NSRegularExpression(pattern: pattern, options: []),
               let result =  regx.firstMatch(in: self, options: [], range: NSRange(location: 0, length: characters.count))
        else{
          return
        }
        //获取结果
        let link = (self as NSString).substring(with: result.range(at: 1))
        let text = (self as NSString).substring(with: result.range(at: 2))
        print(link + "-----" + text)
        
        
        
        
        
        
    }
    
    
    
}
