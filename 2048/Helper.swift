//
//  Helper.swift
//  2048
//
//  Created by Jenny on 2020/5/13.
//  Copyright © 2020年 Jenny. All rights reserved.
//

import Foundation
//import AVFoundation
import AudioToolbox

class Helper {
    static let KEY_SCORE = "score"
    static let KEY_BEST_SCORE = "bestScore"
    static let KEY_GRID_ARR = "gridArr"
    
    static let userDefault = UserDefaults.standard
    
    static var soundID:SystemSoundID = 0
    //获取声音地址
    static let path = Bundle.main.path(forResource: "audio/biu", ofType: "m4a")
    //地址转换
    static let baseURL = NSURL(fileURLWithPath: path!)
    
    static func setStr(key:String, value:String) {
        userDefault.set(value, forKey: key)
    }
    static func setArr(key:String, value:Array<String>) {
        userDefault.set(value, forKey: key)
    }
    static func getStr(key:String, def: String) -> String {
        return userDefault.string(forKey: key) ?? def
    }
    static func getArr(key:String) -> Array<String> {
        return userDefault.array(forKey: key) as! [String]? ?? [String]()
    }
    // 播放短的音频
    static func playBiu() {
        AudioServicesCreateSystemSoundID(baseURL, &soundID)
        //播放声音
        AudioServicesPlaySystemSound(soundID)
    }
}
