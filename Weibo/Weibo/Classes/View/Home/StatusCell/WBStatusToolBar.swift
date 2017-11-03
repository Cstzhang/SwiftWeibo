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
            retweetedButton.setTitle("\(viewModel?.status.reposts_count)", for: .normal)
            commentButton.setTitle("\(viewModel?.status.comment_count)", for: .normal)
            likeButton.setTitle("\(viewModel?.status.attitudes_count)", for: .normal)
            
        }
        
    }
    
    
    //转发
     @IBOutlet weak var retweetedButton: UIButton!
     //评论
     @IBOutlet weak var commentButton: UIButton!
     //点赞
     @IBOutlet weak var likeButton: UIButton!
    


}
