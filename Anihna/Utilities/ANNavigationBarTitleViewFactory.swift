//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.
//
import UIKit

class ANStandardTitleView : UIView {
    
    let label = UILabel.init()
    
    var widthConstraint : NSLayoutConstraint?
    var heightConstraint : NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    func setupViews() {
        
        label.textAlignment = .left
        label.font = ANStyleGuideManager.Fonts.Fields.Global3HeaderPageTitle()
        label.textColor  = ANStyleGuideManager.Colors.Title()
        self.backgroundColor = ANStyleGuideManager.Colors.Background()
        
        self.addSubview(label)
        _ = label.constrainFitInside(constrainInside: self, insets: UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 0))
        
        self.widthConstraint = self.constrainWidth(width: 0)
        self.heightConstraint = self.constrainHeight(height: 0)
    }
}

class ANNavigationBarTitleViewFactory: NSObject {
    
    static func leftAlignedTitleView(withTitle title: String) -> ANStandardTitleView {
        
        let titleView = ANStandardTitleView.init(frame: CGRect.init(x: 0, y: 0, width: 1000, height: 30))
        
        titleView.label.text = title
        
        return titleView
    }
    
    static func standardTitleView(withTitle title: String, hasDragBar : Bool = false) -> UIView {
        
        let titleView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 1000, height: 30))
        let label = UILabel.init()
        label.textAlignment = .center
        label.font = ANStyleGuideManager.Fonts.Fields.Global3HeaderPageTitle()
        label.textColor  = ANStyleGuideManager.Colors.Title()
        label.text = title
        
        titleView.backgroundColor = ANStyleGuideManager.Colors.Background()
        titleView.addSubview(label)
        _ = label.constrainFitInside(constrainInside: titleView)
        
        if hasDragBar {
            let dragView = UIView.init()
            dragView.backgroundColor = ANStyleGuideManager.Colors.CoolGray3
            titleView.addSubview(dragView)
            _ = dragView.constrainHeight(height: 1)
            _ = dragView.constrainWidth(width: 28)
            _ = dragView.constrainXCenter(to: titleView)
            _ = dragView.constrainToTop(constrainTo: titleView, amount: -4)
        }
        
        return titleView
    }
    
    static func standardLightWeightTitleView(withTitle title: String) -> UIView {
        
        let titleView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 1000, height: 30))
        let label = UILabel.init()
        label.textAlignment = .center
        label.font = ANStyleGuideManager.Fonts.Fields.Global2HeaderPageTitle()
        label.textColor = ANStyleGuideManager.Colors.Title()
        label.text = title
        
        titleView.backgroundColor = ANStyleGuideManager.Colors.Background()
        titleView.addSubview(label)
        _ = label.constrainFitInside(constrainInside: titleView)
        
        return titleView
    }
    
    static func tappableTitleView(title: String, hasDragBar: Bool) -> UIView {
        let titleView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 1000, height: 30))
        let label = UILabel.init()
        label.textAlignment = .right
        label.font = ANStyleGuideManager.Fonts.Body.Body2()
        label.textColor = ANStyleGuideManager.Colors.Title()
        label.text = title
        
        let imageView = UIImageView.init()
        let image = UIImage.init(named: "Icon - Carat Down- - Black")
        imageView.image = image
        let side: CGFloat = 16
        _ = imageView.constrainWidth(width: side)
        _ = imageView.constrainHeight(height: side)
        
        let stackView = UIStackView.init()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(imageView)
        
        titleView.backgroundColor = ANStyleGuideManager.Colors.Background()
        titleView.addSubview(stackView)
        _ = stackView.constrainCenterInside(constrainInside: titleView)
        
        if hasDragBar {
            let dragView = UIView.init()
            dragView.backgroundColor = ANStyleGuideManager.Colors.CoolGray3
            titleView.addSubview(dragView)
            _ = dragView.constrainHeight(height: 1)
            _ = dragView.constrainWidth(width: 28)
            _ = dragView.constrainXCenter(to: titleView)
            _ = dragView.constrainToTop(constrainTo: titleView, amount: 0)
        }
        
        return titleView
    }


    
    static func standardCallingTitleView(withTitle title: String) -> UIView {
        
        let titleView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 1000, height: 30))
        titleView.backgroundColor = ANStyleGuideManager.Colors.Background()
        let label = UILabel.init()
        label.textAlignment = .center
        label.font = ANStyleGuideManager.Fonts.Fields.Global2HeaderPageTitle()
        label.textColor = ANStyleGuideManager.Colors.Title()
        label.text = title
        
        titleView.addSubview(label)
        _ = label.constrainFitInside(constrainInside: titleView)
        
        return titleView
    }
}
