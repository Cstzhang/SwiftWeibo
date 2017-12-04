//
//  WBEmoticonInputVIew.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/30.
//  Copyright © 2017年 zhangzb. All rights reserved.
//  自定义表情键盘视图

import UIKit
private let cellId = "cellId"
class WBEmoticonInputVIew: UIView {
    
    @IBOutlet weak var toolBar: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    /// 加载nib 返回输入视图
    //  选中表情回调闭包
    private var seletedEmoticonCallBack:((_ emoticon:ZBEmoticon?)->())?
    
    /// - Returns: 返回视图
    class func inputView(seletcedEmoticon:@escaping (_ emoticon:ZBEmoticon?)->())->WBEmoticonInputVIew{
        let nib = UINib(nibName: "WBEmoticonInputVIew", bundle: nil)
        let v  = nib.instantiate(withOwner: nil, options: nil)[0] as! WBEmoticonInputVIew
        //记录闭包
         v.seletedEmoticonCallBack = seletcedEmoticon
        return v
    }
    //注册可重用cell
    override func awakeFromNib() {
        collectionView.backgroundColor = UIColor.white
        collectionView.register(ZBEmoticonCell.self, forCellWithReuseIdentifier: cellId)
    }

}


extension WBEmoticonInputVIew: UICollectionViewDataSource{
    //分组数量
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ZBEmoticonManager.shared.packages.count
    }
    //返回每个分组中 页 的数量 每个分组表情包页数 emoticons / 20
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ZBEmoticonManager.shared.packages[section].numberOfPages
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ZBEmoticonCell
        cell.emoticons = ZBEmoticonManager.shared.packages[indexPath.section].emotico(page: indexPath.item)
        //设置代理 -不适合用闭包
        cell.delegate = self
        return cell
    }
    
    
    
    
}
//代理协议方法 实现点击
extension WBEmoticonInputVIew:ZBEmoticonCellDelegate{
    
    /// 选中的表情回调
    ///
    /// - Parameters:
    ///   - cell: 分页cell
    ///   - em: 选中的表情，删除为nil
    func emoticonCellDidSelectedEmoticon(cell: ZBEmoticonCell, em: ZBEmoticon?) {
      //执行闭包回调
        seletedEmoticonCallBack?(em)
        //添加最近使用的表情
        guard let em = em  else {
            return
        }
        //记录使用的表情
        ZBEmoticonManager.shared.recentEmoticon(em: em)
        
    }
}





