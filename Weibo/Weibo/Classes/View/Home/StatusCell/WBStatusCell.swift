//
//  WBStatusCell.swift
//  Weibo
//
//  Created by zhangzb on 2017/11/2.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit
//微博cell的协议 (可选协议 需要加 @objc  方法需要： @objc optional)
@objc protocol WBStatusCellDelegate:NSObjectProtocol {
   //微博cell 中选中urL
   @objc optional func statusCellDidSelectURLString(cell:WBStatusCell,urlString:String)
}


class WBStatusCell: UITableViewCell {
    //代理属性
    weak var delegate: WBStatusCellDelegate?
    //微博视图模型
    var  viewModel:WBStatusViewModel?{
        didSet{
            //正文
            statusLabel.attributedText = viewModel?.statusAttrText
            //昵称
            nameLabel.text = viewModel?.status.user?.screen_name
            //会员图标 在model中计算准备好
            memberIconView.image = viewModel?.memberIcon
            //认证
            vipIconView.image = viewModel?.vipIcon
            //头像
            iconView.zb_setImage(urlString: viewModel?.status.user?.profile_image_url, placeholderImage: UIImage(named:"avatar_default_big"),isAvatar: true)
            //底部工具栏
            toolBar.viewModel = viewModel!
            //配图视图数据
            pictureView.viewModel = viewModel!
            //设置被转发微博的文字
            retweetedLabel?.attributedText = viewModel?.retweetedAttrText
            //设置来源
            sourceLabel.text = viewModel?.status.source
            //创建时间
            timeLabel.text = viewModel?.status.creatDate?.zb_dateDescription

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
    @IBOutlet weak var statusLabel: FFLabel!
    //底部工具栏
    @IBOutlet weak var toolBar: WBStatusToolBar!
    //配图视图
    @IBOutlet weak var pictureView: WBStatusPictureView!
    
    //原创微博没有转发微博
    @IBOutlet weak var retweetedLabel: FFLabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //离屏渲染 异步绘制  离屏渲染需要在GPU和CPU之间切换，耗电厉害，如果cell性能已经不错，就不需要这么优化了
        self.layer.drawsAsynchronously = true
        //栅格化 异步绘制后，会生成一张独立的图像，cell在屏幕上滚动，实际滚动的是一张图
        //cell优化后 尽量减少图层，相当于只有一层
        //停止滚动后，可以接受监听
        self.layer.shouldRasterize = true
        //使用栅格化必须指定分辨率
        self.layer.rasterizationScale = UIScreen.main.scale
        // Initialization code
        //设置微博文本代理
        statusLabel.delegate = self
        retweetedLabel?.delegate = self
        
    }
    
    
}

extension WBStatusCell:FFLabelDelegate {
    func labelDidSelectedLinkText(label: FFLabel, text: String) {
        //判断是否是url
        if !text.hasPrefix("http://") {
            return
        }
        //插入？ 表示代理没有实现协议方法，就什么都不做反之强行执行
        delegate?.statusCellDidSelectURLString?(cell: self, urlString: text)
    }
    
    
}
