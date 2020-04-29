//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.
//
import Foundation
import UIKit

extension UIColor {
    class func random() -> UIColor {
        let control : UInt32 = 256
        let r = (CGFloat(arc4random_uniform(control) + 1) / 256)
        let g = (CGFloat(arc4random_uniform(control) + 1) / 256)
        let b = (CGFloat(arc4random_uniform(control) + 1) / 256)
        
        return UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}

extension UIColor {
    convenience init(hexString:String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        // if empty string, make it clear color
        if hexString == "" {
            self.init(red:0, green:0, blue:0, alpha:0)
            return
        }
        
        var color:UInt64 = 0
        scanner.scanHexInt64(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
}

extension UIColor {
    
    func rgb() -> (Int, Int, Int) {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
//            let iAlpha = Int(fAlpha * 255.0)
            
            return (iRed, iGreen, iBlue)
        }
        
        return (0, 0, 0)
    }
}
