//
//  HomeViewController.swift
//  Weibo
//
//  Created by zhangzb on 2017/7/28.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class HomeViewController: BaseViewController {
    fileprivate lazy var statusList = [String]()
    

    //加载数据源 假数据
    override func loadData() {
       //测试网络数据加载
        let urlString = "https://api.weibo.com/2/statuses/user_timeline.json"
        let params = ["access_token":"2.00aCMggCHdipjB89ce96f2760mSK47"]
        NetWorkManager.shared.get(urlString, parameters: params, progress: nil, success: { (_, json) in
            print(json ?? "success")
        }) { (_, error) in
            print(error)

        }
        
        
        
        
       // 模拟延时加载数据
        print("加载数据")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2.0) {
            for i in 0..<15 {
                if self.isPullup{
                //上拉
                   self.statusList.append("上拉 \(i)")
                }else{
                //下拉
                 self.statusList.insert(i.description, at: 0)
                }
               
            }
            print("刷新表格")
            self.isPullup = false
            //结束刷新
            self.refreshControl?.endRefreshing()
            //刷新表格数据
            self.tableView?.reloadData()
            
        }
      
        
    }
    
    
    //显示好友的方法
    @objc fileprivate  func showFriends()  {
        print("查看好友")
        let vc = DemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    

}

// MARK: - 表格数据源方法

extension HomeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = statusList[indexPath.row]
        
        return cell
        
    }

}


extension HomeViewController{
    

    //navigationItem重写 设置导航栏按钮
    override func setupTableView() {
        super.setupTableView()
        //添加左侧按钮
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        //注册cell
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
    }
    
    
    
}
