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
    /// - Returns: 返回视图
    class func inputView()->WBEmoticonInputVIew{
        let nib = UINib(nibName: "WBEmoticonInputVIew", bundle: nil)
        let v  = nib.instantiate(withOwner: nil, options: nil)[0] as! WBEmoticonInputVIew
        return v
    }
    //注册可重用cell
    override func awakeFromNib() {
        collectionView.backgroundColor = UIColor.white
        let nib  = UINib(nibName: "ZBEmoticonCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellId)
    }

}


extension WBEmoticonInputVIew: UICollectionViewDataSource{
    //分组数量
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ZBEmoticonManager.shared.packages.count
    }
    //返回每个分组中 页 的数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ZBEmoticonCell
        cell.label.text = "\(indexPath.section) - \(indexPath.item)"
        return cell
    }
    
    
    
    
}
