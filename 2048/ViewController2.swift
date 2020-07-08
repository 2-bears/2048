//
//  GameViewController.swift
//  2048
//
//  Created by Jenny on 2020/5/7.
//  Copyright © 2020年 Jenny. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    private var parentVc : ViewController1!
    
    func setParentVc(parentVc : ViewController1) {
        self.parentVc = parentVc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        addBtn()
    }
    
    func addBtn() {
        let wid = view.frame.width
        let hei = view.frame.height
        let backBtn = UIButton(frame: CGRect(x: wid/2 - 40, y: hei/3, width: 80, height: 40))
        setBtn(title: "返 回2", btn: backBtn)
        // 跳转到新的页面
        backBtn.addTarget(self, action: #selector(goBackView), for: .touchUpInside)
    }
    
    func setBtn(title: String, btn: UIButton) {
        btn.setTitle(title, for: .normal)
        btn.contentHorizontalAlignment = .center
        //  btn.contentVerticalAlignment = .center
        btn.setTitleColor(UIColor.blue, for: .normal)
        view.addSubview(btn)
    }
    
    @objc func goBackView() {
        parentVc.dismiss(animated: false, completion: nil)
    }
}
