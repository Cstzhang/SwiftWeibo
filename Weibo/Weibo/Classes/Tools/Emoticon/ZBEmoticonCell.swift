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
        let rowCount  = 3
        let colCount = 7
        for i  in 0..<21 {
            let row  =  i / colCount
            let col = i % rowCount
            let btn  = UIButton()
            btn.backgroundColor = UIColor.red
            contentView.addSubview(btn)
        }
    }
    
}
