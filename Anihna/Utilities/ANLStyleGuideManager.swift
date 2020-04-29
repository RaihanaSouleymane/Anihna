//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.
//
import UIKit


class ANLStyleGuideManager: ANStyleGuideManager {
    static var shared = ANStyleGuideManager.init()
    
    struct ANColors {
        static func ConversationlistTextColors() -> UIColor {
            if let color = UIColor.init(named: "ConversationlistTextColors") {
                return color
            } else {
                return ANStyleGuideManager.Colors.Gray
            }
        }

        static func SMSIncomingBubbleColor() -> UIColor {
            if let color = UIColor.init(named: "SMSIncomingBubbleColor") {
                 return color
            } else {
                return ANStyleGuideManager.Colors.White
            }
        }
        
        static func SMSOutgoingBubbleColor() -> UIColor {
            if let color = UIColor.init(named: "SMSOutgoingBubbleColor") {
                 return color
            } else {
                return ANStyleGuideManager.Colors.Theme
            }
        }
        
        static func OTTIncomingBubbleColor() -> UIColor {
            if let color = UIColor.init(named: "OTTIncomingBubbleColor") {
                 return color
            } else {
                return ANStyleGuideManager.Colors.White
            }
        }
        
        static func OTTOutgoingBubbleColor() -> UIColor {
            if let color = UIColor.init(named: "OTTOutgoingBubbleColor") {
                 return color
            } else {
                return ANStyleGuideManager.Colors.Theme
            }
        }
        
        static func SMSIncomingTextColor() -> UIColor {
            if let color = UIColor.init(named: "SMSIncomingTextColor") {
                 return color
            } else {
                return ANStyleGuideManager.Colors.Black
            }
        }
        
        static func SMSOutgoingTextColor() -> UIColor {
            if let color = UIColor.init(named: "SMSOutgoingTextColor") {
                 return color
            } else {
                return ANStyleGuideManager.Colors.White
            }
        }
        
        static func OTTIncomingTextColor() -> UIColor {
            if let color = UIColor.init(named: "OTTIncomingTextColor") {
                 return color
            } else {
                return ANStyleGuideManager.Colors.Black
            }
        }
        
        static func OTTOutgoingTextColor() -> UIColor {
            if let color = UIColor.init(named: "OTTOutgoingTextColor") {
                 return color
            } else {
                return ANStyleGuideManager.Colors.White
            }
        }
        
        static func CallLogBorder() -> UIColor {
            if let color = UIColor.init(named: "CallLogBorder") {
                 return color
            } else {
                return ANStyleGuideManager.Colors.HorizontalRule
            }
        }
        
        static func IncomingMessageBorder() -> UIColor {
            if let color = UIColor.init(named: "IncomingMessageBorder") {
                 return color
            } else {
                return ANStyleGuideManager.Colors.HorizontalRule
            }
        }
        
        static func OnCallShortcutTextColor() -> UIColor {
            if let color = UIColor.init(named: "OnCallShortcutTextColor") {
                 return color
            } else {
                return ANStyleGuideManager.Colors.Black
            }
        }
        
        static func ControlMessageTextColor() -> UIColor {
            if let color = UIColor.init(named: "ControlMessageTextColor") {
                 return color
            } else {
                return ANStyleGuideManager.Colors.Black
            }
        }
    }
    
    struct ANFonts {
        struct Fields {
            static func SearchBar() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 14)!
            }
        }
        
        struct OnCall {
            static func ContactInfoName() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 22.0)!
            }
        }
        
        struct Messages {
            public static func ControlMessage() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 12)!
            }
        }
    }

    private override init() {
        super.init()
    }
    
    // MARK: - Sizes, etc

    override func messageCornerRadius() -> CGFloat {
        // TODO: detect when accessibility text size is changed.
        return 16
    }
    
    override func customBackgroundSystemMessageBackgroundColor() -> UIColor {
        return ANStyleGuideManager.Colors.Black.withAlphaComponent(0.5)
    }
}
