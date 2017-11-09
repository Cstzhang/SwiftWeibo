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
    ///   - placeholderImage: 是否是圆头像
    func zb_setImage(urlString:String!,placeholderImage:UIImage?,isAvatar:Bool = false)  {
        //处理url
        guard  let urlString = urlString,
               let url  = URL(string:urlString) else{
            //设置占位图形
            image = placeholderImage
            return
        }
        sd_setImage(with: url, placeholderImage: placeholderImage, options: [], progress: nil) {[weak self] (image, _, _, _) in
            //完成回调 对图形进行判断是否是头像
            if isAvatar {
                self?.image = image?.zb_avatarImage(size: self?.bounds.size)
            }
            
            
        }
        
        
    }
    
    
}
