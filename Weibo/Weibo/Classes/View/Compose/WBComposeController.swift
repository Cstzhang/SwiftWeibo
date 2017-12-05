//
//  WBComposeController.swift
//  Weibo
//
//  Created by 恒信永利 on 2017/11/23.
//  Copyright © 2017年 zhangzb. All rights reserved.
//

import UIKit
import SVProgressHUD
class WBComposeController: UIViewController {
    //文本编辑视图
    @IBOutlet weak var textView: WBComposeTextView!
    //底部工具栏
    @IBOutlet weak var toolBar: UIToolbar!
    //发布按钮
    @IBOutlet var sendButton: UIButton!
    //标题label
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet weak var toolBarBottomCons: NSLayoutConstraint!
    
    //表情输入视图
    lazy var emoticonInputView:WBEmoticonInputVIew = WBEmoticonInputVIew.inputView { [weak self] (emoticon) in
        //处理输入的表情
        self?.textView.insertEmoticon(em: emoticon)//表情字符插入文本框[图文混排]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //布局UI
        setupUI()
        
        //监听键盘通知 UIWindow
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(keyboardChanged),
                                               name:NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //打开键盘
        textView.becomeFirstResponder()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //关闭键盘
        textView.resignFirstResponder()
    }
    
    // keyboardChangedFrame 键盘高度变化
    @objc private func keyboardChanged(n:Notification){
        //1 目标 rect
        guard let rect  = (n.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = (n.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else{
            return
        }
        //2 设置底部约束的高度
        let offset  = view.bounds.height - rect.origin.y
        // 3 更新底部约束
        toolBarBottomCons.constant = offset
        // 4 动画
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    @objc private func close(){
        dismiss(animated: true, completion: nil)
        
    }
    //MARK: -发布微博
    @IBAction func postStatus(_ sender: Any) {
     //print("点击发布")
        //1 获取微博表情微博文字字符串/
        guard  let text = textView.emoticonText else{
            return
        }
        //2 发布(目前API已经不支持了)
        let image  = UIImage(named: "icon_small_kangaroo_loading_1")
        NetWorkManager.shared.postStatus(textStatus: text,image: image) { (json, isSuccess) in
          //  print(json ?? "")
            SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
            let message = isSuccess ? "发布成功" : "发布失败"
            SVProgressHUD.showInfo(withStatus: message)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                SVProgressHUD.setDefaultStyle(.light)
                self.close()
            })
            
        }
        
    }
    
    /// 切换表情键盘
    @objc private func emoticonKeyboard(){
        //print("切换表情键盘")
        // textView.inputView就是文本框的输入视图 系统默认键盘的时候 视图为nil
        // (1)视图的宽度就是屏幕的宽度 高度可自定义
//        emoticonInputView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 253))
        //切换键盘
        textView.inputView = (textView.inputView == nil) ? emoticonInputView : nil
//        //(2)输入的助理视图
//        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
//        // 键盘消失，主题视图随之消失
//        textView.inputAccessoryView = toolBar
        //(3)刷新视图
        textView.reloadInputViews()
    }
    
}

//MARK: -UITextViewDelegate

extension WBComposeController:UITextViewDelegate{
    //文字变化
    func textViewDidChange(_ textView: UITextView) {
        sendButton.isEnabled = textView.hasText
        
    }

    
    
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
        //遍历数组
        for s in itemSettings {
            guard let imageName = s["imageName"] else{
                continue
            }
            let image  = UIImage(named: imageName)
            let iamgeHL = UIImage(named:imageName + "_highlighted")
            
            let btn = UIButton()
            btn.setImage(image, for: [])
            btn.setImage(iamgeHL, for: .highlighted)
            if  let actionName  = s["actionName"]{
                btn.addTarget(self, action: Selector(actionName), for: .touchUpInside)
            }
            
            //追加按钮
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


