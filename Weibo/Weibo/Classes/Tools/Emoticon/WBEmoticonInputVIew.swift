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
    //分页控件
    @IBOutlet weak var pageControl: UIPageControl!
    //工具栏
    @IBOutlet weak var toolBar: WBEmoticonToolBar!
    //表情view
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
        //注册可重用cell
        collectionView.register(ZBEmoticonCell.self, forCellWithReuseIdentifier: cellId)
        //设置代理
        toolBar.delegate = self
        
    }

}

//工具栏点击代理方法
extension WBEmoticonInputVIew:WBEmoticonToolBarDelegate{
    func emoticonToolBarDidSelectedItemIndex(toolBar: WBEmoticonToolBar, index: Int) {
      //让collectionView滚动到对应分组
        let indexPath  = IndexPath(item: 0, section: index)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
     // 设置分组按钮的选中状态
        toolBar.selectedIndex = index
    }
    
}
//滚动修改分页显示
extension WBEmoticonInputVIew:UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1. 获取中心点
        var center  = scrollView.center
        center.x += scrollView.contentOffset.x
        //2 当前显示的cell 的indexPath
        let paths = collectionView.indexPathsForVisibleItems
        //3 判断中心点在哪一个页面上
        var targetIndexPath:IndexPath?
        for indexPath in paths {
            // 1> 根据indexPath 获得cell
            let cell = collectionView.cellForItem(at: indexPath)
            // 2> cell是否包含中心点
            if cell?.frame.contains(center) == true{
                targetIndexPath = indexPath
                break
            }
        }
        //判断是否找到目标indexPath
        guard let target = targetIndexPath else {
            return
        }
        //显示对应的分组
        toolBar.selectedIndex = target.section
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
        //如果当前collectionView 就是最近的分组 不添加使用次数
        let indexPath  = collectionView.indexPathsForVisibleItems[0]
        if indexPath.section == 0 {
            return
        }
        //记录使用的表情
        ZBEmoticonManager.shared.recentEmoticon(em: em)
        //刷新数据
        var indexSet  = IndexSet()
        indexSet.insert(0)
        collectionView.reloadSections(indexSet)
    }
}





