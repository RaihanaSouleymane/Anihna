//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.
//

import UIKit

class ANRotatingView : UIView {
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        addSubview(imageView)
     //  imageView.translatesAutoresizingMaskIntoConstraints = false
        
//        let height = NSLayoutConstraint(item: self.imageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0.0)
//        let width = NSLayoutConstraint(item: self.imageView, attribute: .width, relatedBy: .equal, toItem: self.imageView, attribute: .width, multiplier: 1, constant: 0)

//        self.addConstraint(width)
//        self.addConstraint(height)
       // _ =  imageView.constrainFitInside(constrainInside: self, insets: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
           _ =  imageView.constrainFitInside(constrainInside: self)
       
        
//       imageView.constrainCenterHorizontallyInside(constrainInside: self)
//        _ = imageView.constrainToBottom(constrainTo: self, amount: 0.0)
//
        self.imageView.alpha = 0.0
        self.clipsToBounds = true
        backgroundColor = ANStyleGuideManager.Colors.Background()
    }
    
    func animateImageOn(withImage image : UIImage) {
        
        self.imageView.image = image
       //self.imageView.backgroundColor = UIColor.yellow
        
        let startDegrees : CGFloat = 180; //the value in degrees
        let rotationTrans = CGAffineTransform(rotationAngle: startDegrees * CGFloat(Double.pi)/180);
        let scaleTrans = CGAffineTransform(scaleX: 0.1, y: 0.1)
        let startTrans = scaleTrans.concatenating(rotationTrans)
        self.imageView.transform = startTrans
        
        let finalRotTrans = CGAffineTransform(rotationAngle: 0);
        let finalScaleTrans = CGAffineTransform(scaleX: 1.0, y: 1.0)
        let finalTrans = finalRotTrans.concatenating(finalScaleTrans)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .beginFromCurrentState, animations: {
            self.imageView.alpha = 1.0
            self.imageView.transform = finalTrans
        }) { (complete) in
        }

        self.imageView.contentMode = .scaleAspectFit


    }
    
    func animateImageOff(completionHandler : @escaping () -> Void) {
        
        // if we do not have an image yet, ignore the request
        if self.imageView.image == nil {
            completionHandler()
            return
        }
        
        let finalRotTrans = CGAffineTransform(rotationAngle: 180);
        let finalScaleTrans = CGAffineTransform(scaleX: 0.1, y: 0.1)
        let finalTrans = finalRotTrans.concatenating(finalScaleTrans)
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .beginFromCurrentState, animations: {
            self.imageView.alpha = 0.0
            self.imageView.transform = finalTrans
        }) { (complete) in
            completionHandler()
        }
    }
}

