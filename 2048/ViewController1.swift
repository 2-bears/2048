//
//  GameViewController.swift
//  2048
//
//  Created by Jenny on 2020/5/7.
//  Copyright © 2020年 Jenny. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {
    
    var parentVc : UIViewController!
    
    func setParentVc(parentVc : UIViewController) {
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
        let backBtn = UIButton(frame: CGRect(x: wid/2 - 60, y: hei/3, width: 120, height: 40))
        let nextBtn = UIButton(frame: CGRect(x: wid/2 - 60, y: hei/3 + 80, width: 120, height: 40+40))
        setBtn(title: "返 回", btn: backBtn)
        setBtn(title: "下一个页面", btn: nextBtn)
        // 跳转到新的页面
        backBtn.addTarget(self, action: #selector(goBackView), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(goNextView), for: .touchUpInside)
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
    @objc func goNextView() {
        let nextVc = ViewController2()
        nextVc.setParentVc(parentVc: self)
        self.present(nextVc, animated: false, completion: nil)
    }
}
