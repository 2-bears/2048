//
//  BoardPanel.swift
//  2048
//
//  Created by Jenny on 2020/5/8.
//  Copyright © 2020年 Jenny. All rights reserved.
//

import Foundation
import UIKit

class BoardPanel : UIView {
    
    var moveFinish: Bool = true
    
    let SPACE :CGFloat = 8     // space betewwn each grid
    let DIM = 4
    var BLOCK_WID :CGFloat!
    let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

    var gridArr : [UILabel]!    // 定义grid块数组，每个是一个label。背景label
    var digitArr = [UILabel]()  // 数字块。不知如何赋值为nil
    
    let mainScene : MainScene!
    
    var maxDigit: Int = 2    // 当前最大数字块
    
    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, view: MainScene) {
        self.mainScene = view
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        self.backgroundColor = UIColor(red: 0.75, green: 1, blue: 0.85, alpha: 1)
        BLOCK_WID = (self.frame.width - 5*SPACE)/4
        // 数组先随便初始化一下
        gridArr = [UILabel](repeating: emptyLabel, count:16)
        initGridArr()
        // 初始随机生成2个方块
        insertRandUnit()
        insertRandUnit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initGridArr() {
        for i in 0..<DIM*DIM {
            // 背景空白label
            gridArr[i] = getEmptyGrid(index : i)
            self.addSubview(gridArr[i])
            // 数字块的不加入到view中
            digitArr.append(getEmptyGrid(index: i))
        }
    }
    
    func getEmptyGrid(index: Int) ->UILabel {
        //NSLog(String(index))
        // 根据grid位置下标计算坐标
        let row = index / 4    //行,从0开始
        let col = index % 4    //列,从0开始
        let x = SPACE*CGFloat(col + 1) + BLOCK_WID * CGFloat(col)
        let y = SPACE*CGFloat(row + 1) + BLOCK_WID * CGFloat(row)
        
        let label = UILabel(frame: CGRect(x: x, y: y, width: BLOCK_WID, height: BLOCK_WID))
        label.textAlignment = .center
        label.minimumScaleFactor = 1
        //设置圆角
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.text = ""
        label.backgroundColor = UIColor.white
        //NSLog("return")
        return label
    }
    
    // 随机插入方块
    func insertRandUnit() {
        let emptyIndexArr = getRandEmptyGrids()
//NSLog(String(emptyIndexArr!.count))
        if emptyIndexArr!.isEmpty {
            NSLog("全放满了")
            //restart()
            return
        }
        let rand = Int(arc4random_uniform(UInt32(emptyIndexArr!.count)))
        let index = emptyIndexArr![rand]
        let label = digitArr[index]
        self.addSubview(label)   //记得加到view中
        label.text = getRandDigit()
        label.backgroundColor = getBgColor(text: label.text)
    }
    func getRandDigit() -> String {
        srand48(Int(time(nil)))
        let randD = drand48()
        var tmp = maxDigit
        while(tmp > 2) {
            if(randD <= Double(1)/Double(tmp)) {
                return String(tmp/2)
            }
            tmp = tmp/2
        }
        return "2"
    }
    
    // 根据数字不同获取不同的背景色
    func getBgColor(text: String!)->UIColor {
        let iText = Float(text)
        return UIColor(red: CGFloat(0.1*iText!), green: 0.5, blue: 1, alpha: 1)
    }
    // 获取空的grid的index数组
    func getRandEmptyGrids() -> [Int]! {
        var emptyIndexArr = [Int]()
        for i in 0 ..< DIM*DIM {
            if(isEmpty(index: i)) {
                emptyIndexArr.append(i)
            }
        }
        return emptyIndexArr
    }
    
    // 移动动画
    func move(fromIndex : Int, toIndex: Int) {
        let from = digitArr[fromIndex]
        let to = digitArr[toIndex]     //该label是不显示的
        //结束位置有方块且数字不同则什么都不做
        if(to.text != "" && to.text != from.text) {
            return
        }
        //结束位置数字相同合并后移动;空白直接移动
        if(to.text != "") {
            to.text = ""
            to.removeFromSuperview()  //合并的块要移除旧的
            to.backgroundColor = UIColor.white
            from.text = String(2*Int(from.text!)!)
            from.backgroundColor = getBgColor(text: from.text)
            // 积分增加
            mainScene.addScore(score: Int(from.text!)!)
            if(Int(maxDigit) < Int(from.text!)!) {
                maxDigit = Int(from.text!)!
            }
            Helper.playBiu()   //合并时增加音效
        }
        let fromX = from.center.x
        let fromY = from.center.y
        from.center.x = to.center.x
        from.center.y = to.center.y
        to.center.x = fromX
        to.center.y = fromY
        // 交换移动的两个grid
        digitArr[toIndex] = from
        digitArr[fromIndex] = to
    }
    // 向上移动
    func moveUp() {
        for i in 0 ..< DIM*DIM {
            if(!isEmpty(index: i) && i > 3) {
                // 向上移动一格直到到底
                var tmp = i-4;
                while(tmp >= 0) {
                    move(fromIndex: tmp+4, toIndex: tmp)
                    tmp = tmp - 4
                }
            }
        }
    }
    //向下移动
    func moveDown() {
        for i in (0...DIM*DIM-1).reversed() {
            if(!isEmpty(index: i) && i < 12) {
                // 向上移动一格直到到底
                var tmp = i+4
                while(tmp <= 15) {
                    move(fromIndex: tmp-4, toIndex: tmp)
                    tmp = tmp + 4
                }
            }
        }
    }
    // 向左移动
    func moveLeft() {
        for i in (0...DIM*DIM-1) {
            // 最左边一列index分别为0,4,8,12
            if(!isEmpty(index: i) && i % 4 != 0) {
                // 向左index减1
                var tmp = i
                while(tmp % 4 != 0) {
                    move(fromIndex: tmp, toIndex: tmp-1)
                    tmp = tmp - 1
                }
            }
        }
    }
    // 向右移动
    func moveRight() {
        for i in (0...DIM*DIM-1).reversed() {
            // 最右边一列index分别为3,7,11,15
            if(!isEmpty(index: i) && (i+1) % 4 != 0) {
                // 向右index加1
                var tmp = i
                while((tmp+1) % 4 != 0) {
                    move(fromIndex: tmp, toIndex: tmp+1)
                    tmp = tmp + 1
                }
            }
        }
    }

    
    func isEmpty(index : Int) -> Bool {
        return digitArr[index].text == ""
    }
    func moveAnimate(direction: String) {
        if(!moveFinish) {
            NSLog("动画正在执行...")
            return
        }
        moveFinish = false
        UIView.animate(withDuration: 0.1, animations: {
            if(direction == "up") {
                self.moveUp()
            } else if(direction == "down") {
                self.moveDown()
            } else if(direction == "left") {
                self.moveLeft()
            } else if(direction == "right") {
                self.moveRight()
            }
         }, completion: { _ in
            // 动画完成之后调用，不然数据改变会影响动画函数的执行
            self.insertRandUnit()
            self.moveFinish = true
        })
        //NSLog("动画正在异步执行,但动画后面代码已经开始执行了")
        saveData()   //保存数据
    }
    //恢复4*4面板上的数据
    func loadData() {
        let saveArr:[String] = Helper.getArr(key: Helper.KEY_GRID_ARR)
        if(saveArr.isEmpty) {
            return
        }
        for i in 0 ..< DIM*DIM {
            let label:UILabel = digitArr[i]
            let val = saveArr[i]
            if(val != "") {
                label.text = val
                label.backgroundColor = getBgColor(text: val)
                self.addSubview(label)
                if(Int(val)! > maxDigit) {
                    maxDigit = Int(val)!
                }
            }
        }
    }
    // 保存数据
    func saveData() {
        var arr = [String]()
        for i in 0 ..< DIM*DIM {
            let label:UILabel = digitArr[i]
            arr.append(label.text!)
        }
        Helper.setArr(key: Helper.KEY_GRID_ARR, value: arr)
    }
    // 判断游戏是否结束, 没有可以合并和放的位置
    func isOver() -> Bool {
        let isOver = true
        for i in 0 ..< DIM*DIM {
            let label:UILabel = digitArr[i]
            if(label.text == "") {
                return false
            }
        }
        return isOver
    }
    //重新开始
    func restart() {
        for i in 0 ..< DIM*DIM {
            if(!isEmpty(index: i)) {
                let label = digitArr[i]
                label.text = ""
                label.removeFromSuperview()
            }
        }
        mainScene.scoreLabel.text = "0"
        insertRandUnit()
    }

}
