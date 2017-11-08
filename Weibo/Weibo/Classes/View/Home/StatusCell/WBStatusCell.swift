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
            //高度
            pictureView.heightCons.constant = viewModel?.pictureViewSize.height ?? 0
            
            
            //配图数据 （原创/被转发）
            pictureView.urls = viewModel?.picURLs
            //Test
            //            if viewModel?.status.pic_urls?.count ?? 0 > 4 {
            //
            //                var picURLS = viewModel!.status.pic_urls!
            //
            //                picURLS.removeSubrange((picURLS.startIndex + 4)..<picURLS.endIndex)
            //
            //                pictureView.urls = picURLS
            //
            //            }else{
            //                   pictureView.urls = viewModel?.status.pic_urls
            //
            //            }
            
            
            //            //来源
            //            sourceLabel.text = viewModel?.status.source
            //            //时间
            //            timeLabel.text = viewModel?.status.created_at
            
            
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
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
