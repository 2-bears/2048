//
//  MainScene.swift
//  2048
//
//  Created by Jenny on 2020/5/7.
//  Copyright © 2020年 Jenny. All rights reserved.
//

import Foundation
import UIKit

class MainScene : UIView {
    private var titleLabel : UILabel!
    var scoreLabel : UILabel!
    var boardPanel : BoardPanel!
    
    // define some paremeters
    let SPACE :CGFloat = 8     // space betewwn each grid
    let DIM = 4
    var BLOCK_WID :CGFloat!
    var titleWidth :CGFloat!
    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        // set background
        self.backgroundColor = UIColor(red: 0.9, green: 0.8, blue: 1, alpha: 1)
        initParameters()
        initTitleLabel()
        initScoreLabel()
        initBoardPanel()
        loadData()
    }
    private func initParameters() {
        BLOCK_WID = (self.frame.width - 5*SPACE)/4
        titleWidth = (self.frame.width - 3*SPACE)/2
    }
    
    // init title label in the up-left
    private func initTitleLabel() {
        titleLabel = UILabel(frame: CGRect(x: SPACE, y: SPACE, width: titleWidth, height: BLOCK_WID))
        titleLabel.textAlignment = .center
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        self.addSubview(titleLabel)
        titleLabel.text = "2048"
        titleLabel.backgroundColor = UIColor.yellow
    }
    // init score label
    private func initScoreLabel() {
        scoreLabel = UILabel(frame: CGRect(x: 2*SPACE + titleWidth, y: SPACE, width: titleWidth, height: BLOCK_WID))
        scoreLabel.textAlignment = .center
        scoreLabel.minimumScaleFactor = 0.5
        scoreLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        self.addSubview(scoreLabel)
        scoreLabel.text = "0"
        scoreLabel.backgroundColor = UIColor(red: 0.5, green: 0.8, blue: 0.97, alpha: 1)

    }
    // init the 4*4 board panel which will includes 16 blocks
    func initBoardPanel() {
        let y = BLOCK_WID + 3*SPACE
        boardPanel = BoardPanel(x: 0, y: y, width: self.frame.width, height: self.frame.width,view: self)
        self.addSubview(boardPanel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addScore(score : Int!) {
        let curScore = Int(scoreLabel.text!)!
        scoreLabel.text = String(curScore + score)
        Helper.setStr(key: Helper.KEY_SCORE, value: scoreLabel.text!)
        var best = Helper.getStr(key: Helper.KEY_BEST_SCORE, def:"0")
        if(curScore + score > Int(best)!) {
            best = String(curScore + score)
            Helper.setStr(key: Helper.KEY_BEST_SCORE, value: String(best))
            titleLabel.text = "best " + best
        }
    }
    // 恢复积分及最好积分数据
    func loadData() {
        let best = Helper.getStr(key: Helper.KEY_BEST_SCORE, def:"0")
        let score = Helper.getStr(key: Helper.KEY_SCORE, def:"0")
        titleLabel.text = "best " + best
        scoreLabel.text = score
        boardPanel.loadData()
    }
}
