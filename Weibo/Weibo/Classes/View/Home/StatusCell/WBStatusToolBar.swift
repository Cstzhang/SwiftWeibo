//
//  WBStatusToolBar.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/3.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

class WBStatusToolBar: UIView {
    
    var viewModel:WBStatusViewModel?{
        didSet{
           retweetedButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, -8.0, 0.0, 0.0)
           commentButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, -8.0, 0.0, 0.0)
           likeButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, -8.0, 0.0, 0.0)
           retweetedButton.setTitle(viewModel?.retweetStr, for: .normal)
           commentButton.setTitle(viewModel?.commentStr, for: .normal)
           likeButton.setTitle(viewModel?.likeStr, for: .normal)
        }
    }
    //转发
     @IBOutlet weak var retweetedButton: UIButton!
     //评论
     @IBOutlet weak var commentButton: UIButton!
     //点赞
     @IBOutlet weak var likeButton: UIButton!
    
}
