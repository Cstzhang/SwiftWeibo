//
//  WBComposeController.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/23.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit

class WBComposeController: UIViewController {
    //文本编辑视图
    @IBOutlet weak var textView: UITextView!
    //底部工具栏
    @IBOutlet weak var toolBar: UIToolbar!
    //发布按钮
    @IBOutlet var sendButton: UIButton!
    //标题label
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc private func close(){
        dismiss(animated: true, completion: nil)
        
    }
    //MARK: -发布微博
    @IBAction func postStatus(_ sender: Any) {
     print("点击发布")
    }
    
    
    //发布按钮
//    lazy var sendButton:UIButton = {
//        let btn = UIButton()
//        btn.setTitle("发布", for: [])
//        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//        btn.setTitleColor(UIColor.white, for: [])
//        btn.setTitleColor(UIColor.gray, for: .disabled)
//        btn.setBackgroundImage(UIImage(named:"common_button_orange_highlighted"), for: .highlighted)
//        btn.setBackgroundImage(UIImage(named:"common_button_orange"), for: [])
//        btn.setBackgroundImage(UIImage(named:"common_button_white_disable"), for: .disabled)
//        btn.frame = CGRect(x: 0 , y: 0 , width: 45 , height: 35)
//        return btn
//    }()
}

//MARK: -UI 底部工具
private extension WBComposeController{
    //设置UI
    func setupUI() -> () {
        view.backgroundColor = UIColor.white
        setupNavigationBar()
        setupToolBar()
    }
    //设置工具栏
    func setupToolBar() -> () {
        let itemSettings = [["imageName": "compose_toolbar_picture"],
                            ["imageName": "compose_mentionbutton_background"],
                            ["imageName": "compose_trendbutton_background"],
                            ["imageName": "compose_emoticonbutton_background", "actionName": "emoticonKeyboard"],
                            ["imageName": "compose_add_background"]]
        var items = [UIBarButtonItem]()
        for s in itemSettings {
            guard let imageName = s["imageName"] else{
                continue
            }
            let image  = UIImage(named: imageName)
            let iamgeHL = UIImage(named:imageName + "_highlighted")
            
            let btn = UIButton()
            btn.setImage(image, for: [])
            btn.setImage(iamgeHL, for: .highlighted)
            
            items.append(UIBarButtonItem(customView: btn))
            //弹簧
            items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil))
        }
        items.removeLast()
        toolBar.items = items
        
    }
    
    //设置导航
    func setupNavigationBar() -> () {
          navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(close))
          navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: sendButton)
          sendButton.isEnabled = false
          navigationItem.titleView = titleLabel
    }
    
    
}


