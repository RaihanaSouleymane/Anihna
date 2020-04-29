//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.
//

import UIKit

public class ANButtonFactory: NSObject {
    
    public class func ANGhostActionButton(text: String, foregroundColor: UIColor, backgroundColor: UIColor, button : UIButton? = nil, borderWidth: CGFloat = 4.0) -> UIButton {
        var ghostButton : UIButton
        //let backgroundColor = UIColor.clear
        
        if let button = button {
            ghostButton = button
        } else {
            ghostButton = UIButton.init(type: .custom)
        }
        
        ghostButton.titleLabel?.font = ANStyleGuideManager.Fonts.CustomizeLine.Title()
        ghostButton.setTitle(text, for: .normal)
        ghostButton.setTitleColor(foregroundColor, for: .normal)
        ghostButton.setBackgroundImage(UIImage.imageWithColor(color: backgroundColor, alpha: 1.0), for: .normal)
        
        ghostButton.setTitleColor(ANStyleGuideManager.Colors.InvertedTitle(), for: .highlighted)
        ghostButton.setBackgroundImage(UIImage.imageWithColor(color: foregroundColor, alpha: 1.0), for: .highlighted)

        ghostButton.setTitleColor(ANStyleGuideManager.Colors.CoolGray6, for: .disabled)
        ghostButton.setBackgroundImage(UIImage.imageWithColor(color: ANStyleGuideManager.Colors.CoolGray3, alpha: 1.0), for: .disabled)
        
        // border
        ghostButton.layer.borderColor = foregroundColor.cgColor
        ghostButton.layer.borderWidth = borderWidth
        ghostButton.clipsToBounds = true
        
        return ghostButton
    }
    
    public class func navigationBarButton(imageName: String, preferredSideLength: CGFloat) -> UIBarButtonItem {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 0, y: 0, width: preferredSideLength, height: preferredSideLength)
        button.setImage(UIImage.init(named: imageName), for: .normal)
        return UIBarButtonItem.init(customView: button)
    }
    
    public class func confirmationButtonView(title: String?) -> ANConfirmationButtonView {
        let buttonView = ANConfirmationButtonView.init(frame: CGRect.zero)
        
        if let title = title {
            buttonView.button.setTitle(title, for: .normal)
        }
        
        return buttonView
    }
}

public class ANConfirmationButtonView : UIView {
    public let button = UIButton.init()
    public let separatorView = UIView.init()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    func commonInit() {
        // separatorView
        self.separatorView.backgroundColor = ANStyleGuideManager.Colors.CoolGray3
        self.addSubview(separatorView)
        _ = self.separatorView.constrainHeight(height: 1)
        _ = self.separatorView.constrainToTop(constrainTo: self)
        _ = self.separatorView.constrainToLeft(constrainTo: self)
        _ = self.separatorView.constrainToRight(constrainTo: self)

        // button
        self.addSubview(button)
        button.titleLabel?.font = ANStyleGuideManager.Fonts.Button.ButtonLabel1()
        button.setTitleColor(ANStyleGuideManager.Colors.Title(), for: .normal)
        button.setTitleColor(ANStyleGuideManager.Colors.InvertedTitle(), for: .highlighted)
        button.setBackgroundImage(UIImage.imageWithColor(color: ANStyleGuideManager.Colors.Background(), alpha: 1.0), for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(color: ANStyleGuideManager.Colors.InvertedBackground(), alpha: 1.0), for: .highlighted)


        button.clipsToBounds = true
        _ = button.constrainFitInside(constrainInside: self, insets: UIEdgeInsets.init(top: 10, left: 10, bottom: -10, right: -10))
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.button.layer.cornerRadius = self.button.height / 2
    }
}

public class ANBlackConfirmationButtonView : UIView {
    public let button = UIButton.init()
    public let separatorView = UIView.init()
    
    // default colors
    var fgColor = ANStyleGuideManager.Colors.InvertedTitle()
    var bgColor = ANStyleGuideManager.Colors.InvertedBackground()
    
    public convenience init(foregroundColor: UIColor, backgroundColor: UIColor) {
        self.init(frame: CGRect.zero)
        
        self.backgroundColor = ANStyleGuideManager.Colors.Background()
        self.fgColor = foregroundColor
        self.bgColor = backgroundColor
        
        self.commonInit()
    }

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }

    public func enable() {
        self.button.isEnabled = true
    }

    public func disable() {
        self.button.isEnabled = false
    }
    
    func commonInit() {
        self.addSubview(button)
        button.titleLabel?.font = ANStyleGuideManager.Fonts.Button.ButtonLabel1()
        
        self.backgroundColor = ANStyleGuideManager.Colors.Background()
        
        self.button.addTarget(self, action: #selector(onHighlight), for: [.touchDown])
        self.button.addTarget(self, action: #selector(onUnhighlight), for: [.touchDragExit, .touchUpInside, .touchUpOutside, .touchCancel])
        
        button.clipsToBounds = true
        if self.frame.size.width >=  UIScreen.main.bounds.width - 32 {
            _ = button.constrainWidth(width: self.frame.size.width * 0.6)
            _ = button.constrainToTop(constrainTo: self, amount: 10)
            _ = button.constrainToBottom(constrainTo: self, amount: -10)
            _ = button.constrainXCenter(to: self)
        }else{
        _ = button.constrainFitInside(constrainInside: self, insets: UIEdgeInsets.init(top: 10, left: 0, bottom: -10, right: 0))
        }
        
        self.setColors(foreground: self.fgColor, background: self.bgColor)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.button.layer.cornerRadius = self.button.height / 2
        self.button.layer.borderWidth = 1.5
    }

    public func setColors(foreground: UIColor, background: UIColor, temporary: Bool = false) {
        if temporary == false {
            self.fgColor = foreground
            self.bgColor = background
        }
        
        self.button.setTitleColor(foreground, for: .normal)
        self.button.backgroundColor = background

        self.button.setBackgroundImage(UIImage.imageWithColor(color: ANStyleGuideManager.Colors.CoolGray3, alpha: 1.0), for: .disabled)
        self.button.setTitleColor(ANStyleGuideManager.Colors.CoolGray6, for: .disabled)

        self.button.layer.borderColor = foreground.cgColor
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 12.0, *) {
            if let prevStyle = previousTraitCollection?.userInterfaceStyle, prevStyle != self.traitCollection.userInterfaceStyle {
                self.setColors(foreground: fgColor, background: bgColor)
            }
        } else {
            // Fallback on earlier versions
        }
    }

    @objc func onHighlight() {
        self.setColors(foreground: bgColor, background: fgColor, temporary: true)
    }
    
    @objc func onUnhighlight() {
        self.setColors(foreground: fgColor, background: bgColor, temporary: true)
    }
}

public class ANBlueConfirmationButtonView : UIView {
    public let button = UIButton.init()
    public let separatorView = UIView.init()

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    private func commonInit() {
        self.backgroundColor = UIColor.clear
        self.addSubview(button)

        button.titleLabel?.font = ANStyleGuideManager.Fonts.Button.ButtonLabel1()
        button.setTitleColor(ANStyleGuideManager.Colors.Theme, for: .normal)
        button.setTitleColor(ANStyleGuideManager.Colors.InvertedTitle(), for: .highlighted)
        button.setBackgroundImage(UIImage.imageWithColor(color: ANStyleGuideManager.Colors.Background(), alpha: 1.0), for: .normal)


        button.setBackgroundImage(UIImage.imageWithColor(color: ANStyleGuideManager.Colors.Theme, alpha: 1.0), for: .highlighted)

        button.clipsToBounds = true
        _ = button.constrainFitInside(constrainInside: self, insets: UIEdgeInsets.init(top: 10, left: 10, bottom: -10, right: -10))
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        self.button.layer.cornerRadius = self.button.height / 2
        self.button.layer.borderColor = ANStyleGuideManager.Colors.Theme.cgColor
        self.button.layer.borderWidth = 1.5
    }
}

public class ANPrimaryButton : UIButton {
    
    let buttonWidth : CGFloat = 220 // default
    static let ButtonHeight : CGFloat = 40 // set in style guide
    
    // default colors
    var fgColor = ANStyleGuideManager.Colors.Title()
    var bgColor = ANStyleGuideManager.Colors.Background()
    
    public convenience init(foregroundColor: UIColor, backgroundColor: UIColor) {
        self.init(frame: CGRect.zero)
        
        self.fgColor = foregroundColor
        self.bgColor = backgroundColor
        
        self.commonInit()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit() {
        
        self.titleLabel?.font = ANStyleGuideManager.Fonts.Body.Body3()
        setColors()
        self.clipsToBounds = true
        
        _ = self.constrainHeight(height: ANPrimaryButton.ButtonHeight)
        _ = self.constrainWidth(width: buttonWidth)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.height / 2
        self.layer.borderColor = ANStyleGuideManager.Colors.Black.cgColor
        self.layer.borderWidth = 1.5
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 12.0, *) {
            if let prevStyle = previousTraitCollection?.userInterfaceStyle, prevStyle != self.traitCollection.userInterfaceStyle {
                setColors()
            }
        } else {
            // Fallback on earlier versions
        }
    }

    public func setColors() {
        self.setTitleColor(fgColor, for: .normal)
        self.setTitleColor(bgColor, for: .highlighted)

        self.setBackgroundImage(UIImage.imageWithColor(color: bgColor, alpha: 1.0), for: .normal)
        self.setBackgroundImage(UIImage.imageWithColor(color: fgColor, alpha: 1.0), for: .highlighted)
    }
}

public class ANDialogSmallButton : UIButton {
    
    public static let ButtonWidth : CGFloat = 220 // default
    public static let ButtonHeight : CGFloat = 32 // set in style guide
    
    public var buttonWidth : CGFloat = 0
    public var buttonHeight : CGFloat = 0
    
    var widthConstraint: NSLayoutConstraint!
    
    // default colors
    public var fgColor = ANStyleGuideManager.Colors.Title()
    public var bgColor = ANStyleGuideManager.Colors.Background()
    
    public convenience init(foregroundColor: UIColor, backgroundColor: UIColor, buttonHeight: CGFloat = ANDialogSmallButton.ButtonHeight, buttonWidth: CGFloat = ANDialogSmallButton.ButtonWidth) {
        
        self.init(frame: CGRect.zero)
        self.buttonWidth = buttonWidth
        self.buttonHeight = buttonHeight
        
        self.fgColor = foregroundColor
        self.bgColor = backgroundColor
        
        self.commonInit()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel?.font = ANStyleGuideManager.Fonts.Body.Body3()
        
        self.clipsToBounds = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit() {
        
        self.titleLabel?.font = ANStyleGuideManager.Fonts.Body.Body3()
        
        self.setColors(foreground: fgColor, background: bgColor)
        
        self.clipsToBounds = true
        
        _ = self.constrainHeight(height: self.buttonHeight)
        widthConstraint = self.constrainWidth(width: buttonWidth)
        
        self.addTarget(self, action: #selector(onHighlight), for: [.touchDown])
        self.addTarget(self, action: #selector(onUnhighlight), for: [.touchDragExit, .touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.height / 2
        
        self.layer.borderWidth = 1.5
        self.layer.borderColor = fgColor.cgColor
    }
    
    @objc func onHighlight() {
        self.setColors(foreground: bgColor, background: fgColor, temporary: true)
    }
    
    @objc func onUnhighlight() {
        self.setColors(foreground: fgColor, background: bgColor, temporary: true)
    }
    
    public func setColors(foreground: UIColor, background: UIColor, temporary: Bool = false) {
        if temporary == false {
            self.fgColor = foreground
            self.bgColor = background
        }
        
        self.setTitleColor(foreground, for: .normal)
        self.backgroundColor = background
        
        self.setBackgroundImage(UIImage.imageWithColor(color: ANStyleGuideManager.Colors.CoolGray3, alpha: 1.0), for: .disabled)
        self.setTitleColor(ANStyleGuideManager.Colors.CoolGray6, for: .disabled)

        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                
                self.layer.borderColor = background.cgColor
                
            } else {
                self.layer.borderColor = foreground.cgColor
            }
        } else {
            self.layer.borderColor =  foreground.cgColor
        }
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 12.0, *) {
            if let prevStyle = previousTraitCollection?.userInterfaceStyle, prevStyle != self.traitCollection.userInterfaceStyle {
                setColors(foreground: fgColor, background: bgColor)
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

public class ANListButton : UIButton {
    
    var buttonWidth : CGFloat = 135 // default
    var buttonHeight : CGFloat = 25 // set in style guide
    
    // default colors
    var fgColor = ANStyleGuideManager.Colors.Title()
    var bgColor = ANStyleGuideManager.Colors.Background()
    
    public convenience init(foregroundColor: UIColor, backgroundColor: UIColor, buttonHeight: CGFloat? = 25, buttnWidth: CGFloat? = 135) {
        self.init(frame: CGRect.zero)
        
        self.fgColor = foregroundColor
        self.bgColor = backgroundColor

        self.buttonHeight = buttonHeight!
        self.buttonWidth = buttnWidth!
        
        self.commonInit()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit() {
        
        self.titleLabel?.font = ANStyleGuideManager.Fonts.Buttons.List()
        
        self.clipsToBounds = true
        
        _ = self.constrainHeight(height: buttonHeight)
        _ = self.constrainWidth(width: buttonWidth)
        
        self.addTarget(self, action: #selector(onHighlight), for: [.touchDown])
        self.addTarget(self, action: #selector(onUnhighlight), for: [.touchDragExit, .touchUpInside, .touchUpOutside, .touchCancel])
        
        setColors(foreground: fgColor, background: bgColor)
    }
    
    public func setColors(foreground: UIColor, background: UIColor, temporary: Bool = false) {
        if temporary == false {
            self.fgColor = foreground
            self.bgColor = background
        }
        
        self.setTitleColor(foreground, for: .normal)
        self.backgroundColor = background
        
        self.setBackgroundImage(UIImage.imageWithColor(color: ANStyleGuideManager.Colors.CoolGray3, alpha: 1.0), for: .disabled)
        self.setTitleColor(ANStyleGuideManager.Colors.CoolGray6, for: .disabled)
        
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                self.layer.borderColor = background.cgColor
            } else {
                self.layer.borderColor = foreground.cgColor
            }
        } else {
            self.layer.borderColor = background.cgColor
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.height / 2
        self.layer.borderColor = ANStyleGuideManager.Colors.Title().cgColor
        self.layer.borderWidth = 1.5
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 12.0, *) {
            if let prevStyle = previousTraitCollection?.userInterfaceStyle, prevStyle != self.traitCollection.userInterfaceStyle {
                self.setColors(foreground: fgColor, background: bgColor)
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc func onHighlight() {
        self.setColors(foreground: bgColor, background: fgColor, temporary: true)
    }
    
    @objc func onUnhighlight() {
        self.setColors(foreground: fgColor, background: bgColor, temporary: true)
    }
}

public class ANHollowButton : UIButton {
    
    let buttonWidth : CGFloat = 220 // default
    static let ButtonHeight : CGFloat = 32 // set in style guide
    
    // default colors
    var fgColor = ANStyleGuideManager.Colors.Title()
    
    public convenience init(foregroundColor: UIColor) {
        self.init(type: .custom)
        
        self.fgColor = foregroundColor
        
        self.commonInit()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit() {
        
        self.titleLabel?.font = ANStyleGuideManager.Fonts.Body.Body3()
        
        self.clipsToBounds = true
        
        _ = self.constrainHeight(height: ANHollowButton.ButtonHeight)
        _ = self.constrainWidth(width: buttonWidth)
        
        setColors(foreground: fgColor)
    }
    
    public func setColors(foreground: UIColor, temporary: Bool = false) {
        if temporary == false {
            self.fgColor = foreground
        }
        
        self.setTitleColor(foreground, for: .normal)
        
        self.setBackgroundImage(UIImage.imageWithColor(color: ANStyleGuideManager.Colors.CoolGray3, alpha: 1.0), for: .disabled)
        self.setTitleColor(ANStyleGuideManager.Colors.CoolGray6, for: .disabled)
        
        self.layer.borderColor = foreground.cgColor
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.height / 2
        self.layer.borderColor = ANStyleGuideManager.Colors.Title().cgColor
        self.layer.borderWidth = 1.5
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 12.0, *) {
            if let prevStyle = previousTraitCollection?.userInterfaceStyle, prevStyle != self.traitCollection.userInterfaceStyle {
                self.setColors(foreground: fgColor)
            }
        }
    }
}

public class ANBorderlessDialogButton : UIButton {
    
    static let ButtonWidth : CGFloat = 220 // default
    static let ButtonHeight : CGFloat = 32 // set in style guide
    
    var buttonWidth : CGFloat = 0
    var buttonHeight : CGFloat = 0
    
    var widthConstraint: NSLayoutConstraint!
    
    // default colors
    var fgColor = ANStyleGuideManager.Colors.Title()
    var bgColor = ANStyleGuideManager.Colors.Background()
    
    public convenience init(foregroundColor: UIColor, backgroundColor: UIColor, buttonHeight: CGFloat = ANDialogSmallButton.ButtonHeight, buttonWidth: CGFloat = ANDialogSmallButton.ButtonWidth) {
        
        self.init(frame: CGRect.zero)
        self.buttonWidth = buttonWidth
        self.buttonHeight = buttonHeight
        
        self.fgColor = foregroundColor
        self.bgColor = backgroundColor
        
        self.commonInit()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel?.font = ANStyleGuideManager.Fonts.Body.Body3()
        
        self.clipsToBounds = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit() {
        
        self.titleLabel?.font = ANStyleGuideManager.Fonts.Body.Body3()
        
        self.setColors(foreground: fgColor, background: bgColor)
        
        self.clipsToBounds = true
        
        _ = self.constrainHeight(height: self.buttonHeight)
        widthConstraint = self.constrainWidth(width: buttonWidth)
        
        self.addTarget(self, action: #selector(onHighlight), for: [.touchDown])
        self.addTarget(self, action: #selector(onUnhighlight), for: [.touchDragExit, .touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.height / 2
        
        self.layer.borderWidth = 1.5
        self.layer.borderColor = ANStyleGuideManager.Colors.ConversationListBackground().cgColor  //GrayOrBlack
    }
    
    @objc func onHighlight() {
        self.setColors(foreground: bgColor, background: fgColor, temporary: true)
    }
    
    @objc func onUnhighlight() {
        self.setColors(foreground: fgColor, background: bgColor, temporary: true)
    }
    
    public func setColors(foreground: UIColor, background: UIColor, temporary: Bool = false) {
        if temporary == false {
            self.fgColor = foreground
            self.bgColor = background
        }
        
        self.setTitleColor(foreground, for: .normal)
        self.backgroundColor = background
        
        self.setBackgroundImage(UIImage.imageWithColor(color: ANStyleGuideManager.Colors.CoolGray3, alpha: 1.0), for: .disabled)
        self.setTitleColor(ANStyleGuideManager.Colors.CoolGray6, for: .disabled)
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 12.0, *) {
            if let prevStyle = previousTraitCollection?.userInterfaceStyle, prevStyle != self.traitCollection.userInterfaceStyle {
                setColors(foreground: fgColor, background: bgColor)
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
