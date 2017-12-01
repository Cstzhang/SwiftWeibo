//
//  ZBEmoticonCell.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/30.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit
// 表情的页面cell 每个页面显示20个表情
// 每个cell 和collectionView 一样大小
// 每个cell 用九宫格自行添加20个表情，最后一个位置显示删除按钮
class ZBEmoticonCell: UICollectionViewCell {
    //当前页表情模型数组，最多20个
    var emoticons:[ZBEmoticon]?{
        didSet{
            //1隐藏所有按钮
            for v  in contentView.subviews {
                v.isHidden = true
            }
           //2遍历表情模型数组，设置按钮图形
            for (i,em)  in (emoticons ?? []).enumerated() {
                if let btn = contentView.subviews[i] as? UIButton{
                 btn.setImage(em.image, for: [])//表情图
                 btn.setTitle(em.emoji, for: [])//emoji
                 btn.isHidden = false
                }
            }
        }
        
    }
    
    @IBOutlet weak var label: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
         setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func awakeFromNib() {
//    setupUI()
//    }
    
}


private extension ZBEmoticonCell{
    //联系创建21个按钮 从xib加载，bounds是xib的大小，不是size的大小
    //存代码创建，bounds就是布局属性中的itemsSize
    func setupUI() -> () {
        //3行
        let rowCount  = 3
        //每行7列
        let colCount = 7
        //左右间距
        let leftMargin:CGFloat = 8
        //底部间距，为分页控件留空间
        let bottomMargin:CGFloat = 16
        let w  = (bounds.width - 2*leftMargin) / CGFloat(colCount)
        let h = (bounds.height - bottomMargin) / CGFloat(rowCount)
        
        
        for i  in 0..<21 {
            let row  =  i / colCount
            let col = i % colCount
            let btn  = UIButton()
            let x  = leftMargin + CGFloat(col) * w
            let y  = CGFloat(row) * h
            btn.frame = CGRect(x: x, y: y , width: w, height: h)
            contentView.addSubview(btn)
            //设置按钮字体大小
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        }
    }
    
}
