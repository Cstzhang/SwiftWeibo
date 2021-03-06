//
//  ZBEmoticonCell.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/30.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit
//表情cell的协议
@objc protocol ZBEmoticonCellDelegate:NSObjectProtocol{
    
    /// 表情cell选中表情模型
    ///
    /// - Parameter em: 选中的表情模型 nil 表示删除
    func emoticonCellDidSelectedEmoticon(cell:ZBEmoticonCell ,em:ZBEmoticon?)

}
// 表情的页面cell 每个页面显示20个表情
// 每个cell 和collectionView 一样大小
// 每个cell 用九宫格自行添加20个表情，最后一个位置显示删除按钮
class ZBEmoticonCell: UICollectionViewCell {
    //代理
    weak var delegate:ZBEmoticonCellDelegate?
    //当前页表情模型数组，最多20个
    var emoticons:[ZBEmoticon]?{
        didSet{
            //1隐藏所有按钮
            for v  in contentView.subviews {
                v.isHidden = true
            }
            //显示删除按钮
            contentView.subviews.last?.isHidden = false
            //2遍历表情模型数组，设置按钮图形
            for (i,em)  in (emoticons ?? []).enumerated() {
                if let btn = contentView.subviews[i] as? UIButton{
                //复用cell的问题 如果图像为nil 为清空图片，避免复用
                btn.setImage(em.image, for: [])//表情图
                //如果emoji为nil 会清空tittle
                btn.setTitle(em.emoji, for: [])//emoji
                btn.isHidden = false
                }
            }
        }
        
    }
    //选择图片视图
    private lazy var  tipView = ZBEmoticonTipView()
    
    @IBOutlet weak var label: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
         setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //视图显示， 视图移开
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        guard let w = newWindow else {
            return
        }
        //将视图添加到窗口
        w.addSubview(tipView)
        //默认隐藏
        tipView.isHidden = true
    }
//    override func awakeFromNib() {
//    setupUI()
//    }
    
    /// 选中表情按钮
    ///
    /// - Parameter button: 按钮
    @objc private func selectedEmoticonButton(button:UIButton){
       // print(button)
        // 1 取出tag  0~20  20对应的是删除按钮
        let tag  = button.tag
        // 2 根据tag 判断点的表情按钮 是否是删除按钮
        var em:ZBEmoticon?
        if tag < (emoticons?.count)! {
            em = emoticons?[tag]
        }
        delegate?.emoticonCellDidSelectedEmoticon(cell: self, em: em)
    }
    
    //长按手势识别
    @objc private func longGesture(gesture:UILongPressGestureRecognizer){
       // 获取点击位置
        let location  = gesture.location(in: self)
        guard let button  = buttonWithLocation(location: location) else{
            tipView.isHidden = true
            return
        }
        //处理手势
        switch gesture.state {
        case .began,.changed:
            tipView.isHidden = false
            //坐标系转换 按钮参照cell的坐标转移到 window 的坐标
            let center  = self.convert(button.center, to: window)
            tipView.center = center
            //设置提示视图的表情模型
            if button.tag < (emoticons?.count)!{
                tipView.emoticon = emoticons?[button.tag]
            }
        case .ended:
            tipView.isHidden = true
            //执行选中按钮的函数
            selectedEmoticonButton(button: button)
        case .cancelled:
            tipView.isHidden = true
        default:
            break
        }
        
        
    }
    
    //获取长按的图标
    private func buttonWithLocation(location:CGPoint) -> UIButton?{
        //遍历contentview 所有子视图，如果课件，同事location 确认是按钮
        for btn in contentView.subviews as! [UIButton] {
            if btn.frame.contains(location)  && !btn.isHidden && btn != contentView.subviews.last {
                return btn
            }
        }
        return nil
    }
    
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
        
        //循环创建按钮
        for i  in 0..<21 {
            let row  =  i / colCount
            let col = i % colCount
            let btn  = UIButton()
            let x  = leftMargin + CGFloat(col) * w
            let y  = CGFloat(row) * h
            btn.frame = CGRect(x: x, y: y , width: w, height: h)
            contentView.addSubview(btn)
            btn.tag = i
            //设置按钮字体大小
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
            btn.addTarget(self, action: #selector(selectedEmoticonButton), for: .touchUpInside)
        }
        
        //取出末尾删除按钮
        let removeButtn  = contentView.subviews.last as! UIButton
        let image  = UIImage(named: "compose_emotion_delete_highlighted", in: ZBEmoticonManager.shared.bundle, compatibleWith: nil)
        removeButtn.setImage(image, for: [])
        //添加长按手势
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longGesture))
        longPress.minimumPressDuration = 0.1
        addGestureRecognizer(longPress)
        
    }
    
}
