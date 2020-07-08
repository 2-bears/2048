//
//  GameViewController.swift
//  2048
//
//  Created by Jenny on 2020/5/7.
//  Copyright © 2020年 Jenny. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        addBtn()
    }
    
    func addBtn() {
        let wid = view.frame.width
        let hei = view.frame.height
        let startBtn = UIButton(frame: CGRect(x: wid/2 - 40, y: hei/3, width: 80, height: 40))
        let settingBtn = UIButton(frame: CGRect(x: wid/2 - 40, y: hei/3 + 80, width: 80, height: 40+40))
        setBtn(title: "开 始", btn: startBtn)
        setBtn(title: "自定义弹框", btn: settingBtn)
        // 跳转到新的页面
        startBtn.addTarget(self, action: #selector(goToMainView), for: .touchUpInside)
        settingBtn.addTarget(self, action: #selector(showMyDialog), for: .touchUpInside)

    }
    
    func setBtn(title: String, btn: UIButton) {
        btn.setTitle(title, for: .normal)
        btn.contentHorizontalAlignment = .center
      //  btn.contentVerticalAlignment = .center
        btn.setTitleColor(UIColor.blue, for: .normal)
        view.addSubview(btn)
    }
    
    @objc func goToMainView() {
          self.present(MainViewController(), animated: true, completion: nil)
//        let nextVc = ViewController1()
//        nextVc.setParentVc(parentVc: self)
//        self.present(nextVc, animated: false, completion: nil)
    }
    
    @objc func showMyDialog() {
        let myDialog = MyDialog(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        self.view.addSubview(myDialog)
    }

    
}
