//
//  WBStatusViewModel.swift
//  Weibo
//
//  Created by zhangzb on 2017/11/2.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import Foundation
//单条微博视图模型

//没有继承任何父类 遵守 CustomStringConvertible协议 实现description计算型属性 输出调试信息
/*
1,尽量少计算，所有需要显示的控件提前准备好
2，控件上不要设置设置圆角半径，所有的图像渲染的属性要注意
3，不要动态创建控件，要体检创建好，在显示的时候判断 隐藏还是显示
4，cell中控件的层次越少越好
 
 */



class WBStatusViewModel:CustomStringConvertible {
    //微博模型
    var status = WBStatus()
    var memberIcon:UIImage?
    var vipIcon:UIImage?
    //按钮文字
    var retweetStr:String?
    var commentStr:String?
    var likeStr:String?
    //图片尺寸
    var pictureViewSize = CGSize()
    //如果是被转发的微博，原创微博没有图
    var picURLs : [WBStatusPicture]?{
        return status.retweeted_status?.pic_urls ?? status.pic_urls
    }
    //被转发微博文字
    var retweetedText : String?
    //行高
    var rowHeight:CGFloat = 0

    /// 构造函数
    ///
    /// - Parameter model: 微博模型
    init(model:WBStatus) {
        self.status = model
        if (model.user?.mbrank) ?? 0 > 0 && ((model.user?.mbrank)) ?? 0 < 7{
            let imageName = "common_icon_membership_level\(model.user?.mbrank ?? 1)"
            memberIcon = UIImage(named: imageName)
        }
      //verified_type
        switch model.user?.verified_type ?? -1 {
        case 0:
            vipIcon = UIImage(named:"avatar_vip")
        case 2,3,5:
            vipIcon = UIImage(named:"avatar_enterprise_vip")
        case 200:
            vipIcon = UIImage(named:"avatar_grassroot")
        default:
            break
            
        }
        
        retweetStr = countStr(count: status.reposts_count, defaultStr: "转发")
        
        commentStr = countStr(count: status.comment_count, defaultStr: "评论")
     
        likeStr = countStr(count: status.attitudes_count, defaultStr: "赞")
        
        //计算配图视图大小
        pictureViewSize = calcPictureViewSize(count: picURLs?.count ?? 0)
        

        let screen_name = status.retweeted_status?.user?.screen_name ?? ""
        
        let retweeted_Text = status.retweeted_status?.text ?? ""
        
        //被转发微博文字
        retweetedText = "@" + screen_name + ":" + retweeted_Text
        
//        let regx = NSRegularExpression(
        
        
        
        //计算行高
        updateRowHeight()
        
        
        
        
    }
    
    
    var description: String{
        return status.description
    }
    
    //根据当前的视图模型计算行高
    func updateRowHeight()  {
      //原创微博
      //被转发weibo
        
        let margin:CGFloat = 12
        let iconHeight:CGFloat = 34
        let toolBaRHeight:CGFloat = 35
        let viewSize = CGSize(width: UIScreen.cz_screenWidth() - 2*margin, height: CGFloat(MAXFLOAT))
        let originalFont = UIFont.systemFont(ofSize: 15)
        let retweetedFont = UIFont.systemFont(ofSize: 14)
        //1 计算顶部位置
        var  height:CGFloat = 0
        height = 2 * margin  + iconHeight + margin
        //2 正文高度
        if let text = status.text {
            /*
             1,预期尺寸
             2,选项 换行文本 统一使用NSStringDrawingUsesLineFragmentOrigin
             3<制定字体字典
             
             */
            height += (text as NSString).boundingRect(with: viewSize,
                                            options:.usesLineFragmentOrigin,
                                            attributes: [NSAttributedStringKey.font:originalFont],
                                            context: nil).height
        }
        
        // 3 判断是否转发微博
        
        if status.retweeted_status != nil {
             height += 2*margin
            if let text = retweetedText{
              height +=    (text as NSString).boundingRect(with: viewSize, options:.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:retweetedFont], context: nil).height
            }
        }
        // 4 配图视图
        height += pictureViewSize.height
        height += margin
        // 5 底部工具栏
        height += toolBaRHeight
        // 6 使用属性记录
        rowHeight = height
        
        
    }
    
    /// 用用单个图像的尺寸 更新配图视图的大小
    ///
    /// - Parameter image: 网络缓存的单张视图
    func updateSingleImageSize(image:UIImage)  {
        var size = image.size
        //过宽图像处理
        let maxWidth:CGFloat = 300
        if size.width > maxWidth{
            //设置最大宽度
            size.width = maxWidth
            //等比例调整
            size.height  =  size.width * image.size.height / image.size.width
        }
        //过窄处理
        let minWidth:CGFloat = 40
        if size.width < minWidth{
            //设置最大宽度
            size.width = minWidth
            //等比例调整  特殊处理高度，高度太大处理用户体验/4
            size.height  =  size.width * image.size.height / image.size.width / 4
        }
        
        //顶部+12便于布局
        size.height += WBStatusPictureOutterMargin
        
        pictureViewSize = size
        
        updateRowHeight()
     
    }
    
    /// 一个数字 给描述结果
    ///
    /// - Returns: 结果
    private func countStr(count:Int,defaultStr:String)->String{
        
        if count == 0{
            return defaultStr
        }
        
        if count < 10000{
            return count.description
        }
        
        return String(format: "%.02f 万", Double(count) / 10000)
    }
    
    
    
    private func calcPictureViewSize(count:Int?) -> CGSize {
        
        if count == 0 || count == nil{
            return CGSize()
        }
    
        let row = ((count! - 1)  / 3) + 1
        
        let height = WBStatusPictureOutterMargin + (CGFloat(row)  * WBStatusPictureViewItemWidth) + CGFloat(row-1) * WBStatusPictureInnerMargin
        
        return CGSize(width: WBStatusPictureViewWidth, height: height)
    }
    
    
}
