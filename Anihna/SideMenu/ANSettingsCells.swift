//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.
//

import UIKit

class ServerSettingsDebugCell : UITableViewCell {
    
    let stackView = UIStackView.init()
    
    let versionLabel = UILabel.init()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.axis = .vertical

        
        self.contentView.addSubview(stackView)

        
//        let notesLabel = UILabel.init()
//        _ = notesLabel.constrainHeight(height: 20)
//        notesLabel.numberOfLines = 0
        
        let appNameLabel = UILabel.init()
        let appNameText = "App name: Anihna"
        appNameLabel.text = appNameText
        _ = appNameLabel.constrainHeight(height: 20)
        
        _ = versionLabel.constrainHeight(height: 20)
        
        var buildConfigType = "Debug"
        
        #if DISTRIBUTION
            buildConfigType = "Enterprise"
        #endif
        
        let buildConfigTypeLabel = UILabel.init()
        buildConfigTypeLabel.text = "Build Type: " + buildConfigType
        _ = buildConfigTypeLabel.constrainHeight(height: 20)


        self.stackView.addArrangedSubview(appNameLabel)
        self.stackView.addArrangedSubview(buildConfigTypeLabel)
        self.stackView.addArrangedSubview(versionLabel)
      //  self.stackView.addArrangedSubview(notesLabel)
        
        _ = stackView.constrainToTop(constrainTo: self.contentView, amount: 10)
        _ = stackView.constrainToLeft(constrainTo: self.contentView, amount: 10)
        _ = stackView.constrainToRight(constrainTo: self.contentView, amount: -10)
        _ = stackView.constrainToBottom(constrainTo: self.contentView, amount: -10)
        

            versionLabel.text = "App Version: 1.0)"
            versionLabel.textColor =  ANStyleGuideManager.Colors.Title()


        appNameLabel.textColor = ANStyleGuideManager.Colors.CoolGray6
      //  self.versionLabel.textColor = ANStyleGuideManager.Colors.CoolGray6
       // notesLabel.textColor = ANStyleGuideManager.Colors.CoolGray6
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(versionString: String?) {
        for v in self.stackView.subviews{
            if ((v as? UILabel) != nil) {
                (v as! UILabel).font = ANStyleGuideManager.Fonts.Body.Body6()
            }
        }
        if versionString != nil {
            self.versionLabel.text = "Version: \(versionString!)"
        }
    }
}
