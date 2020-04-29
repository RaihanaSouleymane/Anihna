//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.
//

import UIKit

class ANColorFactory: NSObject {
    
    class func OffWhiteBackgroundColor() -> UIColor {
        return UIColor(red: 242/256, green: 242/256, blue: 242/256, alpha: 1.0)
    }
    
    class func HelpTextColor() -> UIColor {
        return UIColor(red: 123/256, green: 123/256, blue: 123/256, alpha: 1.0)
    }
    
    class func IconBlueColor() -> UIColor {
        return UIColor(red: 46/255, green: 165/255, blue: 253/255, alpha: 1)
    }
    
    class func IconBlueColorLighter() -> UIColor {
        return UIColor(red: 68/255, green: 183/255, blue: 252/255, alpha: 1)
    }
    
    class func TextDarkBlueColor() -> UIColor {
        return UIColor(red: 22/255, green: 78/255, blue:142/255, alpha: 1)
    }
    
    class func TextDarkGrayColor() -> UIColor {
       // return UIColor(red: 22/255, green: 78/255, blue:142/255, alpha: 1)
        return UIColor.darkGray
    }
    
    class func TextGrayColor() -> UIColor {
        // return UIColor(red: 22/255, green: 78/255, blue:142/255, alpha: 1)
        return UIColor.gray
    }
    
    class func TextLightGrayColor() -> UIColor {
        // return UIColor(red: 22/255, green: 78/255, blue:142/255, alpha: 1)
        return UIColor.lightGray
    }
    
    class func TextBlackColor() -> UIColor {
        // return UIColor(red: 22/255, green: 78/255, blue:142/255, alpha: 1)
        return ANStyleGuideManager.Colors.Black
    }

 
    class func ANRedColor() -> UIColor {
        return UIColor(named: "D52B1E")!
    }
    
    class func ANBlackColor() -> UIColor {
        return UIColor(named: "0000000")!
    }
    
    class func ANWhiteColor() -> UIColor {
        return UIColor(named: "FFFFFF")!
    }
    
    class func ANCoolGrayColor1() -> UIColor {
        return UIColor(named: "F6F6F6")!
    }
    
    class func ANCoolGrayColor3() -> UIColor {
        return UIColor(named: "D8DADA")!
    }
    
    class func ANCoolGrayColor6() -> UIColor {
        return UIColor(named: "747676")!
    }
    
    class func ANCoolGrayColor10() -> UIColor {
        return UIColor(named: "333333")!
    }
    
    class func ANBlueColor() -> UIColor {
        return UIColor(named: "62C5FF")!
    }
    
    class func ANDarkBlueColor() -> UIColor {
        return UIColor(named: "457FB1")!
    }
    
    class func ANCallBack() -> UIColor {
        return UIColor(named: "2B2F32")!
    }
    
    class func ANLineNumbers() -> UIColor {
        return UIColor(named: "8CA4B2")!
    }
    
    class func ANClickableText() -> UIColor {
        return UIColor(named: "457FB1")!
    }
    
    class func ANBorder() -> UIColor {
        return UIColor(named: "F1F1F1")!
    }
}
