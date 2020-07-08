//
//  StartViewController.swift
//  2048
//
//  Created by Jenny on 2020/5/16.
//  Copyright © 2020年 Jenny. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    private var mainScene : MainScene!
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置mainSence的大小位置，铺满屏幕
        mainScene = MainScene(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(mainScene)
        setupSwipeEvent();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //NSLog("test start")
        //mainScene.boardPanel!.restar()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // 增加手势事件：上下左右滑动
    func setupSwipeEvent() {
        let upSwipe = UISwipeGestureRecognizer(target:self, action:#selector(onUpSwipe(_:)))
        upSwipe.numberOfTouchesRequired = 1
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target:self,
                                                 action:#selector(onDownSwipe(_:)))
        downSwipe.numberOfTouchesRequired = 1
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target:self, action:#selector(onLeftSwipe(_:)))
        leftSwipe.numberOfTouchesRequired = 1
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target:self, action:#selector(onRightSwipe(_:)))
        rightSwipe.numberOfTouchesRequired = 1
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
    }
    
    // 向上滑动事件处理
    @objc func onUpSwipe(_ swiper:UISwipeGestureRecognizer) {
        //NSLog("向上滑动了")
        moveAnimate(direction: "up")
    }
    // 向上滑动事件处理
    @objc func onDownSwipe(_ swiper:UISwipeGestureRecognizer) {
        //NSLog("向下滑动了")
        moveAnimate(direction: "down")
    }
    // 向上滑动事件处理
    @objc func onLeftSwipe(_ swiper:UISwipeGestureRecognizer) {
        //NSLog("向左滑动了")
        moveAnimate(direction: "left")
    }
    // 向上滑动事件处理
    @objc func onRightSwipe(_ swiper:UISwipeGestureRecognizer) {
        //NSLog("向右滑动了")
        moveAnimate(direction: "right")
    }
    func moveAnimate(direction : String) {
        mainScene.boardPanel.moveAnimate(direction: direction)
        if(mainScene.boardPanel.isOver()) {
            showOverAlert()
        }
    }
    // 游戏结束展示提示框
    func showOverAlert() {
        let alertController = UIAlertController(title: "系统提示",
                                                message: "很遗憾,游戏结束。是否重新开始?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "重新开始", style: .default, handler: {
            action in
            self.mainScene.boardPanel.restart()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
