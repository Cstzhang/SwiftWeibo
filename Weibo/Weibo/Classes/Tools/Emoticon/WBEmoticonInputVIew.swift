//
//  WBEmoticonInputVIew.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/30.
//  Copyright © 2017年 zhangzb. All rights reserved.
//  自定义表情键盘视图

import UIKit

class WBEmoticonInputVIew: UIView {
    
    @IBOutlet weak var toolBar: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    /// 加载nib 返回输入视图
    /// - Returns: 返回视图
    class func inputView()->WBEmoticonInputVIew{
        let nib = UINib(nibName: "WBEmoticonInputVIew", bundle: nil)
        let v  = nib.instantiate(withOwner: nil, options: nil)[0] as! WBEmoticonInputVIew
        return v
    }


}
