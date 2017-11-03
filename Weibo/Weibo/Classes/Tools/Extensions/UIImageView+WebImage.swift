//
//  UIImageView+WebImage.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/3.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import SDWebImage

extension UIImageView{
    
    /// sdwebimage set
    ///
    /// - Parameters:
    ///   - urlString: url
    ///   - placeholderImage: 站位图
    func zb_setImage(urlString:String!,placeholderImage:UIImage?)  {
        //处理url
        guard  let urlString = urlString,
               let url  = URL(string:urlString) else{
            //设置占位图形
            image = placeholderImage
            return
        }
        
        
        sd_setImage(with: url, placeholderImage: placeholderImage, options: [], progress: nil) { (image, _, _, _) in
            
            
            
            
        }
        
        
    }
    
    
}
