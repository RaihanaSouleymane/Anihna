//
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.
//

import UIKit

class ANSearchBarContainer : UIView {
    let searchBar = UISearchBar.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = ANStyleGuideManager.Colors.Background()
        
        addSubview(searchBar)
        _ = searchBar.constrainFitInside(constrainInside: self, insets: UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: -5))
          self.searchBar.searchBarStyle = .minimal
//        self.layer.borderColor = ANStyleGuideManager.shared.imageBorderColor().cgColor
//        self.layer.borderWidth = 0.5
        
        let color = ANStyleGuideManager.Colors.CoolGray6
        self.layer.addBorder(edge: .top, color: color, thickness: 0.5)
        self.layer.addBorder(edge: .bottom, color: color, thickness: 0.5)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

class ANLongRoundStyleTextFieldContainerView : UIView {
    let textField = UITextField.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = ANStyleGuideManager.Colors.Background()
        
        addSubview(textField)
        _ = textField.constrainFitInside(constrainInside: self)
        self.textField.borderStyle = .none
        self.textField.textAlignment = .center
        self.layer.borderColor = ANStyleGuideManager.Colors.Title().cgColor
        self.layer.borderWidth = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.size.height / 2
    }
}

class ANStandardViewFactory: NSObject {
    static func searchBar(placeholderText placeHolderText: String, existingContainer: ANSearchBarContainer? = nil) -> ANSearchBarContainer {
        
        var searchBarContainer : ANSearchBarContainer?
        if let existingContainer = existingContainer {
            searchBarContainer = existingContainer
        } else {
            searchBarContainer = ANSearchBarContainer.init(frame: CGRect.zero)
        }
        
        searchBarContainer?.backgroundColor = ANStyleGuideManager.Colors.Background()
        
        // set white background
        //searchBarContainer!.searchBar.setSearchFieldBackgroundImage(UIImage.imageWithColor(color: UIColor.white, alpha: 1.0, width: 1200, height: 32), for: .normal)

        // Customize search bar internal textField
        if let textField = searchBarContainer!.searchBar.value(forKey: "searchField") as? UITextField {
            textField.tintColor = ANStyleGuideManager.Colors.Title()
            textField.font = ANLStyleGuideManager.ANFonts.Fields.SearchBar()
            textField.borderStyle = .none
            textField.backgroundColor = ANStyleGuideManager.Colors.Background()
            textField.returnKeyType = .done
            searchBarContainer!.searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 10.0, vertical: 0.0)
            // Placeholder text needs an attributed string
            textField.attributedPlaceholder = NSAttributedString.init(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor : ANStyleGuideManager.Colors.Gray, NSAttributedString.Key.font : ANStyleGuideManager.Fonts.Fields.Feed1MessagePreview()])
            
            // Customize Search bar icon color
            if let glassIconView = textField.leftView as? UIImageView {
                glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
                glassIconView.tintColor = ANStyleGuideManager.Colors.Icon()
            }
            
            // Customize Search bar icon color
            if let clearIconView = textField.rightView as? UIImageView {
                clearIconView.image = clearIconView.image?.withRenderingMode(.automatic)
                clearIconView.tintColor = ANStyleGuideManager.Colors.Icon()
            }
            
            // Input text color needs to be set after placeholder to take effect, for some reason.
            textField.textColor = ANStyleGuideManager.Colors.Title()
            searchBarContainer?.searchBar.backgroundColor = ANStyleGuideManager.Colors.Background()
        }
        
        return searchBarContainer!
    }
    
    static func longRoundStyleTextFieldContainerView(placeHolderText : String) -> ANLongRoundStyleTextFieldContainerView {
        let textFieldContainer = ANLongRoundStyleTextFieldContainerView.init(frame: CGRect.zero)
        
        self.updateWithLongRoundStyle(textFieldContainer: textFieldContainer, placeholderText: placeHolderText)
        
        return textFieldContainer
    }
    
    static func updateWithLongRoundStyle(textFieldContainer : ANLongRoundStyleTextFieldContainerView, placeholderText : String) {
        textFieldContainer.textField.font = ANStyleGuideManager.Fonts.Fields.Feed1MessagePreview()
        
        textFieldContainer.backgroundColor = ANStyleGuideManager.Colors.Background()
        
        // Placeholder text needs an attributed string
        textFieldContainer.textField.attributedPlaceholder = NSAttributedString.init(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor : ANStyleGuideManager.Colors.Title(), NSAttributedString.Key.font : ANStyleGuideManager.Fonts.Fields.Feed1MessagePreview()])
        
        // Input text color needs to be set after placeholder to take effect, for some reason.
        textFieldContainer.textField.textColor = ANStyleGuideManager.Colors.Title()
    }
    
    static func updateSegmentedControl(control: UISegmentedControl) {
        
        let font = ANStyleGuideManager.Fonts.Body.Body3()
        let silveryColor = ANStyleGuideManager.Colors.Title()
        
        control.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        control.layer.cornerRadius = control.height / 2
        control.layer.borderColor = silveryColor.cgColor
        control.layer.borderWidth = 1.0
        control.layer.masksToBounds = true
    }
    
   
    static func closeBarButtonItem() -> UIBarButtonItem {
        let closeImage = UIImage.init(named: "Icon - Close - Black")?.withRenderingMode(.alwaysTemplate)
        let closeButton = UIButton.init(type: .custom)
        closeButton.setImage(closeImage, for: .normal)

        if #available(iOS 10.0, *) {
           closeButton.frame = CGRect.init(x: 0, y: 0, width: 24, height: 24)
        } else {
            // Fallback on earlier versions

        //
        let widthConstraint = closeButton.widthAnchor.constraint(equalToConstant: 24)
        let heightConstraint = closeButton.heightAnchor.constraint(equalToConstant: 24)
        heightConstraint.isActive = true
        widthConstraint.isActive = true
        }

        closeButton.imageView?.tintColor = ANStyleGuideManager.Colors.Icon()
        let closeBBI = UIBarButtonItem.init(customView: closeButton)
        
        return closeBBI
    }
    
    static func simpleLabelTableViewPlaceholderView(text: String) -> UIView {
        let container = UIView.init()
        let label = UILabel.init()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = ANStyleGuideManager.Fonts.Body.Body3()
        label.textColor = ANStyleGuideManager.Colors.CoolGray3
        label.text = text
        
        container.addSubview(label)
        _ = label.constrainFitInside(constrainInside: container, insets: UIEdgeInsets.init(top: 20, left: 40, bottom: -20, right: -40))
        
        return container
    }
}


