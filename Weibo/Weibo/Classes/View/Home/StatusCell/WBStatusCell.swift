//
//  WBStatusCell.swift
//  Weibo
//
//  Created by zhangzb on 2017/11/2.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

class WBStatusCell: UITableViewCell {
    //微博视图模型
    var  viewModel:WBStatusViewModel?{
        didSet{
            //正文
            statusLabel.text = viewModel?.status.text
            //昵称
            nameLabel.text = viewModel?.status.user?.screen_name
            //会员图标 在model中计算准备好
            memberIconView.image = viewModel?.memberIcon
            //认
            vipIconView.image = viewModel?.vipIcon
            //头像
            iconView.zb_setImage(urlString: viewModel?.status.user?.profile_image_url, placeholderImage: UIImage(named:"avatar_default_big"),isAvatar: true)
            //底部工具栏
            toolBar.viewModel = viewModel!
            //配图视图数据
            pictureView.viewModel = viewModel!
            //设置被转发微博的文字
            retweetedLabel?.text = viewModel?.retweetedText
        }
    }
    //头像
    @IBOutlet weak var iconView: UIImageView!
    //姓名
    @IBOutlet weak var nameLabel: UILabel!
    //会员图标
    @IBOutlet weak var memberIconView: UIImageView!
    //时间
    @IBOutlet weak var timeLabel: UILabel!
    //来源
    @IBOutlet weak var sourceLabel: UILabel!
    //认证
    @IBOutlet weak var vipIconView: UIImageView!
    //正文
    @IBOutlet weak var statusLabel: UILabel!
    //底部工具栏
    @IBOutlet weak var toolBar: WBStatusToolBar!
    //配图视图
    @IBOutlet weak var pictureView: WBStatusPictureView!
    
    //原创微博没有转发微博
    @IBOutlet weak var retweetedLabel: UILabel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
