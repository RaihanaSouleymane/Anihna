//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.
//
import UIKit

open class ANStyleGuideManager: NSObject {

    public static var baseShared = ANStyleGuideManager.init()

    public struct Colors {
        public static let White = UIColor.init(hexString: "FFFFFF")
        public static let defaultBackground = UIColor.init(hexString: "FAFAFA")
        public static let LineSelectorBorderColor = UIColor.init(hexString:"F1F1F1")
        public static let HorizontalRule = UIColor.init(hexString:"D8DADA")
        public static let Theme = UIColor.init(hexString: "57B1DF")
        public static let CallToAction = UIColor.init(hexString: "0088CE")
        public static let Gray = UIColor.init(hexString: "9B9B9B")//DisabledTextGray
        public static let CoolGray1 = UIColor.init(hexString: "F6F6F6")
        public static let CoolGray3 = UIColor.init(hexString: "D8DADA")// disabled button backgroung color
        public static let CoolGray6 = UIColor.init(hexString: "747676")
        public static let CoolGray10 = UIColor.init(hexString: "0D1012")
        public static let Black = UIColor.init(hexString: "000000")
        public static let Red = UIColor.init(hexString: "D52B1E")
        public static let Orange = UIColor.init(hexString: "ED7000")
        public static let KeypadHorizontalRule = UIColor.init(hexString: "2E3032")
        public static let Clear = UIColor.clear
        public static let Green = UIColor.init(hexString: "#79A819")
        public static let Charcoal = UIColor.init(hexString: "#4a4a4a")
        public static let themeblue = UIColor(hexString: "#57b1df")
        public static let pumpkin = UIColor(hexString: "#ed7000")
        public static let _SelectedToken = UIColor(hexString: "#8CA4B2")
        public static let OnCallGreen = UIColor(hexString: "#78ba30")

        public static func Title() -> UIColor {

            if let color = UIColor.init(named: "Title") {
                return color
            } else {
                return ANStyleGuideManager.Colors.Black
            }
        }

        public static func InvertedTitle() -> UIColor {
            if let color = UIColor.init(named: "InvertedTitle") {
                return color
            } else {
                return ANStyleGuideManager.Colors.White
            }
        }

        public static func Subtitle() -> UIColor {
            if let color = UIColor.init(named: "Subtitle") {
                return color
            } else {
                return ANStyleGuideManager.Colors.Black
            }
        }

        public static func Background() -> UIColor {
            if let color = UIColor.init(named: "Background") {
                return color
            } else {
                return ANStyleGuideManager.Colors.White
            }
        }

        public static func ConversationViewBackground() -> UIColor {
            if let color = UIColor.init(named: "ConversationViewBackground") {
                return color
            } else {
                return ANStyleGuideManager.Colors.defaultBackground
            }
        }

        public static func TransparentWhite() -> UIColor {
            if let color = UIColor.init(named: "TransparentWhite") {
                return color
            } else {
                return ANStyleGuideManager.Colors.White
            }
        }

        public static func SelectedToken() -> UIColor {
            if let color = UIColor.init(named: "SelectedToken") {
                return color
            } else {
                return ANStyleGuideManager.Colors._SelectedToken
            }
        }

        public static func InvertedBackground() -> UIColor {
            if let color = UIColor.init(named: "InvertedBackground") {
                return color
            } else {
                return ANStyleGuideManager.Colors.Black
            }
        }

        public static func Icon() -> UIColor {
            if let color = UIColor.init(named: "Icon") {
                return color
            } else {
                return ANStyleGuideManager.Colors.Black
            }
        }

        public static func Icon2() -> UIColor {
            if let color = UIColor.init(named: "Icon2") {
                return color
            } else {
                return ANStyleGuideManager.Colors.Theme
            }
        }

        public static func BlackTransparent() -> UIColor {
            if let color = UIColor.init(named: "BlackTransparent") {
                return color
            } else {
                return ANStyleGuideManager.Colors.White
            }
        }

        public static func DarkModeGrayBackground() -> UIColor {
            if let color = UIColor.init(named: "DarkModeGrayBackground") {
                return color
            } else {
                return ANStyleGuideManager.Colors.White
            }
        }

        public static func ConversationListBackground() -> UIColor {
            if let color = UIColor.init(named: "ConversationListBackground") {
                return color
            } else {
                return ANStyleGuideManager.Colors.defaultBackground
            }
        }

        public static func DarkModeCoolGray3() -> UIColor {
            if let color = UIColor.init(named: "DarkModeGrayBackground") {
                return color
            } else {
                return ANStyleGuideManager.Colors.CoolGray3
            }
        }

        public static func SectionHeaderBackground() -> UIColor {
            if let color = UIColor.init(named: "SectionHeaderBackground") {
                return color
            } else {
                return ANStyleGuideManager.Colors.White
            }
        }

        public static func SubtitleWhiteOrCoolGray6() -> UIColor {
            if let color = UIColor.init(named: "SubtitleWhiteOrCoolGray6") {
                return color
            } else {
                return ANStyleGuideManager.Colors.CoolGray6
            }
        }

        public static func ContactShortcutLetters() -> UIColor {
            if let color = UIColor.init(named: "ContactShortcutLetters") {
                return color
            } else {
                return ANStyleGuideManager.Colors.CoolGray6
            }
        }

        public static func DescriptionGrayText() -> UIColor {
            if let color = UIColor.init(named: "DescriptionGrayText") {
                return color
            } else {
                return ANStyleGuideManager.Colors.CoolGray6
            }
        }

        public static func CoolGrays() -> UIColor {
            if let color = UIColor.init(named: "CoolGrays") {
                return color
            } else {
                return ANStyleGuideManager.Colors.CoolGray6
            }
        }

        public static func InvertedCoolGrays() -> UIColor {
            if let color = UIColor.init(named: "InvertedCoolGrays") {
                return color
            } else {
                return ANStyleGuideManager.Colors.CoolGray6
            }
        }

        public static func HeaderCoolGrays() -> UIColor {
            if let color = UIColor.init(named: "HeaderCoolGrays") {
                return color
            } else {
                return ANStyleGuideManager.Colors.CoolGray1
            }
        }

        public static func TermsAndConditionBackground() -> UIColor {
            if let color = UIColor.init(named: "TermsAndConditionBackground") {
                return color
            } else {
                return ANStyleGuideManager.Colors.CoolGray1
            }
        }

        public static func GrayOrBlack() -> UIColor {
            if let color = UIColor.init(named: "GrayOrBlack") {
                return color
            } else {
                return ANStyleGuideManager.Colors.Black
            }
        }
    }

    public static var scaler: CGFloat {
        return UIFont.preferredFont(forTextStyle: .body).pointSize / 17.0
    }

    public struct Fonts {
        public struct Body {

            public static func MessageInput() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 14.0)!
            }

            public static func SectionHeadlineSmall() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 11.0)!
            }

            public static func DialogHeadline() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 20.0)!
            }

            public static func Dialog2() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 16.0)!
            }

            public static func SectionHeadline() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 15.0)!
            }

            public static func LineName() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 15.0)!
            }

            public static func Body1() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 15.0)!
            }

            public static func Body2() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 12.5)!
            }

            public static func Body3() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 13.0)!
            }

            public static func SelectedLineName() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 14.0)!
            }

            public static func Body4() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 15.0)!
            }

            public static func Body5() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 15.0)!
            }

            public static func Body6() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 11.0)!
            }

            public static func Body7() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 15.0)!
            }

            public static func Body8() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 12.0)!
            }

            public static func LineNumber() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 14.0)!
            }

            public static func Body9() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 11.0)!
            }

            public static func Body10() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 10.0)!
            }

            public static func Body110() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 11.0)!
            }

            public static func SelectedLineNumber() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 12.0)!
            }

            public static func Body11() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 18.0)!
            }

            public static func Body12() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 13.5)!
            }
            public static func Body32() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 32.0)!
            }
            public static func Body50() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 50.0)!
            }

            public static func CallToAction() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 12.0)!
            }

            public static func StartKeypad() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 40.0)!
            }

            public static func Emoji() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 40.0)!
            }
        }

        public struct Fields {
            public static func Feed1MessagePreview() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 12)!
            }

            public static func Feed2Timestamp() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 12)!
            }

            public static func FeedPreviewText() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 13)!
            }

            public static func Feed3VoicemailLength() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 11)!
            }

            public static func Feed4MissedCallEvent() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 11)!
            }

            public static func Feed5CallTimeEvent() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 12)!
            }

            public static func Global1ContactName() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 14)!
            }

            public static func Global2HeaderPageTitle() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 15)!
            }
            public static func Global3HeaderPageTitle() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 18)!
            }

            public static func Field1FieldLabel() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 12.0)!
            }

            public static func Field2InputText() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 14)!
            }

            public static func Field3LabelDisabled() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 14)!
            }

            public static func Field4FieldInstructions() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 14.0)!
            }

            public static func Field6Subtitle() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 10)!
            }

            public static func FieldInputTextLarge() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 20)!
            }

            public static func Field7ErrorMessages() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 10)!
            }

            public static func Feed8MissedCallEvent() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 13.5)!
            }
        }

        public struct Conversation {
            public static func Outgoing() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 14)!
            }

            public static func Incoming() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 14)!
            }

            public static func SystemMessageAndTimestamp() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 10.5)!
            }
        }

        public struct CustomizeLine {
            public static func Title() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 14)!
            }

            public static func SubTitle() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 14)!
            }
        }

        public struct Buttons {
            public static func Big() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 14)!
            }

            public static func Small() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 12)!
            }

            public static func Send() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 12)!
            }

            public static func List() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 11)!
            }
        }

        public struct HeadLine {
            public static func Dialog1Headline() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 25.0)!
            }

        }

        public struct KeyPad {
            public static func KeyPadButton() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 25.0)!
            }
            public static func KeyPadletters() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 10.0)!
            }
            public static func KeyPadDialer() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 20.0)!
            }
            public static func KeyPadDialerBig() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 24.0)!
            }

        }

        public struct IntroPages {
            public static func IntroPagesTitle() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 18.0)!
            }
            public static func IntroPagesTitleBig() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 22.0)!
            }

        }

        public struct Button {
            public static func ButtonLabel1() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 14.0)!
            }
        }

        public struct Settings {
            public static func Settings1() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 15.0)!
            }
            public static func Settings2() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 12.0)!
            }
            public static func Settings4() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 15.0)!
            }
            public static func Settings5() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 16.0)!
            }
            public static func Settings111() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 17.0)!
            }
        }

        public struct OnCall {
            public static func OnCall1ContactName() -> UIFont {
                return UIFont.init(name: Fonts.Names.Bold, size: 22.0)!
            }

            public static func OnCall2ContactName() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 18.0)!
            }

            public static func DeviceOrLocation() -> UIFont {
                return UIFont.init(name: Fonts.Names.Regular, size: 14.0)!
            }

            public static func CallButtonLabel() -> UIFont {
                return UIFont.init(name: Fonts.Names.Medium, size: 12.0)!
            }
        }

        public struct Names {
            public static let Regular = "NHaasGroteskTXStd-55Rg"
            public static let Medium = "NHaasGroteskTXStd-65Md"
            public static let Bold = "NHaasGroteskTXStd-75Bd"
        }
    }

    public override init() {
        super.init()
    }

    open func defaultFont(fontSize: CGFloat, bolded: Bool = false) -> UIFont {
        var font : UIFont

        if bolded {
            font = UIFont(name: Fonts.Names.Bold, size: fontSize)!
        } else {
            font = UIFont(name: Fonts.Names.Regular, size: fontSize)!
        }

        return font
    }

    open func defaultDynamicFont(forTextStyle style: UIFont.TextStyle, fontSize: CGFloat, bolded: Bool = false, medium: Bool = false) -> UIFont {

        var font : UIFont?

        if bolded {
            font = UIFont(name: Fonts.Names.Bold, size: fontSize)
        } else if medium {
            font = UIFont(name: Fonts.Names.Medium, size: fontSize)
        } else {
            font = UIFont(name: Fonts.Names.Regular, size: fontSize)

        }
        if #available(iOS 11.0, *){
            let fontMetrics = UIFontMetrics(forTextStyle: style)
            return fontMetrics.scaledFont(for: font!) // crash here if there is a problem for now
        } else {
            // Fallback on earlier versions
            return font!.withSize(ANStyleGuideManager.scaler * font!.pointSize)
        }
    }

    // MARK: - Sizes, etc
    open func messageCornerRadius() -> CGFloat {
        // TODO: detect when accessibility text size is changed.
        return 20
    }

    open func customBackgroundSystemMessageBackgroundColor() -> UIColor {
        return ANStyleGuideManager.Colors.Black.withAlphaComponent(0.5)
    }
}
