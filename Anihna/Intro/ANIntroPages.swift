//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.

import Foundation
import UIKit

enum PageType: Int {
    case whatsNew
    case LaunchScreen
}

class ANIntroPages: NSObject {
    let title: String?
    var pages: [ANmIntroPage]
    var isNeedButton: Bool = false
    var buttonTitle: String?
    var pageType : PageType
    
    static var baseAttributes: [NSAttributedString.Key: Any] = {
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.alignment = .center
        return [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : ANStyleGuideManager.Fonts.Body.Body6(), NSAttributedString.Key(rawValue: NSAttributedString.Key.paragraphStyle.rawValue) : paragraphStyle]
    }()

    lazy var termsAndConditionAttributedText: NSAttributedString = {
        let baseString = String(format: "FIRSTLAUNCH_DISCLAIMERBASE_TEXT","MAIN_BUTTON_TITLE")
        let baseAttrStr = NSAttributedString.init(string: baseString, attributes: ANIntroPages.baseAttributes)
        
        let period = NSAttributedString.init(string: ".", attributes: ANIntroPages.baseAttributes)
        let and = NSAttributedString.init(string: " and ", attributes: ANIntroPages.baseAttributes)
        
        let pp = NSMutableAttributedString.init(string: "Privacy Policy", attributes: ANIntroPages.baseAttributes)
        pp.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: NSMakeRange(0, pp.length))
        pp.addAttribute(NSAttributedString.Key.link, value: "pp", range: NSMakeRange(0, pp.string.count))
        
        let tac = NSMutableAttributedString.init(string: "Terms & Conditions", attributes: ANIntroPages.baseAttributes)
        tac.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: NSMakeRange(0, tac.length))
        tac.addAttribute(NSAttributedString.Key.link, value: "tac", range: NSMakeRange(0, tac.string.count))
        
        
        let finalAttrStr = NSMutableAttributedString.init()
        finalAttrStr.append(baseAttrStr)
        finalAttrStr.append(tac)
        finalAttrStr.append(and)
        finalAttrStr.append(pp)
        finalAttrStr.append(period)
        return finalAttrStr
    }()
    
    lazy var dataMessageAttributedText: NSAttributedString = {
        let baseAttrStr2 = NSAttributedString.init(string: "FIRSTLAUNCH_DISCLAIMERMAIN_TEXT", attributes: ANIntroPages.baseAttributes)
        let learnmore = NSMutableAttributedString.init(string: " Learn More", attributes: ANIntroPages.baseAttributes)
        learnmore.addAttribute(NSAttributedString.Key.link, value: "tac", range: NSMakeRange(0, learnmore.string.count))
        learnmore.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: NSMakeRange(0, learnmore.length))
        let period = NSAttributedString.init(string: ".", attributes: ANIntroPages.baseAttributes)
        
        let finalAttrStr2 = NSMutableAttributedString.init()
        finalAttrStr2.append(baseAttrStr2)
        finalAttrStr2.append(learnmore)
        finalAttrStr2.append(period)
        return finalAttrStr2
    }()
    
    class func pages(type: PageType) -> ANIntroPages? {
        let fileName = type == .whatsNew ? "WhatsNewPages" : "IntroPages"
        var infoDict: NSDictionary?
        if let path = Bundle.main.path(forResource: fileName, ofType: "plist") {
            infoDict = NSDictionary(contentsOfFile: path)
        }
        
        guard let dataDict = infoDict else {
            return nil
        }
        
        
        return ANIntroPages(dict: dataDict as! [String : Any])
    }
    
    init(dict: [String : Any]) {
        self.title = dict["title"] as? String
        self.pageType = dict["pageType"] as! String == "whatsNew" ? .whatsNew : .LaunchScreen
        if let buttonTitle = dict["buttonTitle"] as? String {
            self.isNeedButton = true
            self.buttonTitle = buttonTitle
        }
        
        let pages = dict["pages"] as! [[String : Any]]
        self.pages = ANmIntroPage.instanceOfPage(array: pages, type: self.pageType)
    }
}

class ANmIntroPage: NSObject {
    let title : String
    let subtitle : String
    let imageName : String
    var isNeedButton: Bool = false
    var buttonTitle: String?
    var withinPageType: PageType
    
    class func instanceOfPage(array: [[String: Any]], type: PageType) -> [ANmIntroPage] {
        return array.map({ (pageData) -> ANmIntroPage in
            return ANmIntroPage(dict: pageData, type:type)
        })
    }
    
    init(dict: [String : Any], type: PageType) {
        self.title = dict["title"] as! String
        self.withinPageType = type
        var subTitle = dict["subtitle"] as! String
        subTitle = subTitle.replacingOccurrences(of: "{nextLine}", with: "\n")
        self.subtitle = subTitle.replacingOccurrences(of: "{bullets}", with: "\u{2022}")
        self.imageName = dict["imageName"] as! String
        if let buttonTitle = dict["buttonTitle"] as? String {
            self.isNeedButton = true
            self.buttonTitle = buttonTitle
        }
    }
    
    func attributedText() -> NSAttributedString  {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        paragraph.lineSpacing = 1
        paragraph.headIndent = 0
        let attributes = [NSAttributedString.Key.font : ANStyleGuideManager.Fonts.Body.Body3(),NSAttributedString.Key.paragraphStyle: paragraph]
        return NSMutableAttributedString(string: subtitle, attributes: attributes);
    }
}
