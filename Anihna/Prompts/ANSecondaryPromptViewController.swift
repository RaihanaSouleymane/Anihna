//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.
//

import UIKit

public class ANSecondaryPromptViewController: UIViewController {
    
    public let topSeparatorView = UIView.init()
    public let titleView = UIView.init()
    public let titleLabel = UILabel.init()
    public let contentView = UIView.init()
    public let iconView =  UIView.init()//UIImageView.init()
    public let closeButtonView = UIView.init()
    public let closeButton = UIButton.init()
    
    public let containerView = UIView.init()
    
    public var onDismissAction : (() -> Void)?
    
    public var titleViewHeight: CGFloat = 60
    public var currentHeight : CGFloat = 0
    public let animationDuration : TimeInterval = 0.6
    public var didSetupViews = false
    
    public var timer : Timer?
    
    public convenience init() {
        self.init(nibName: nil, bundle: nil)
        self.setupViews()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        
        if didSetupViews == false {
            didSetupViews = true
            self.setupViews()
        }
        // Do any additional setup after loading the view.
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    private func setupViews() {
        
        self.containerView.backgroundColor = ANStyleGuideManager.Colors.Background()
        
        self.view.addSubview(containerView)
        self.view.addSubview(topSeparatorView)
        
        // separator view
        _ = self.topSeparatorView.constrainToLeft(constrainTo: self.view)
        _ = self.topSeparatorView.constrainToRight(constrainTo: self.view)
        _ = self.topSeparatorView.constrainToTop(constrainTo: self.view)
        _ = self.topSeparatorView.constrainHeight(height: 3)
        self.topSeparatorView.backgroundColor = ANStyleGuideManager.Colors.CoolGray3
        
        _ = containerView.constrainToTop(constrainTo: self.view)
        _ = containerView.constrainToLeft(constrainTo: self.view)
        _ = containerView.constrainToRight(constrainTo: self.view)
        
        
        containerView.addSubview(contentView)
        containerView.addSubview(closeButtonView)
        containerView.addSubview(titleLabel)
        
        // close button
        closeButton.setImage(UIImage.init(named: "Icon - Close - Black"), for: .normal)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(_dismiss))
        closeButtonView.addGestureRecognizer(tap)
        closeButton.isUserInteractionEnabled = false
        let closeButtonSide: CGFloat = 16.0
        _ = closeButton.constrainWidth(width: closeButtonSide)
        _ = closeButton.constrainHeight(height: closeButtonSide)
        closeButtonView.addSubview(closeButton)
        _ = closeButton.constrainFitInside(constrainInside: closeButtonView, insets: UIEdgeInsets.init(top: 10, left: 10, bottom: -10, right: -10))
        _ = closeButtonView.constrainToTop(constrainTo: self.containerView, amount: 10.0)
        _ = closeButtonView.constrainToRight(constrainTo: self.containerView, amount: 10.0)
        
        // title view
        //        _ = titleLabel.constrainFitInside(constrainInside: titleView, insets: UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: -20))
        
        
        
        
        
        // icon view
        
        containerView.addSubview(iconView)
        
        iconView.backgroundColor = ANStyleGuideManager.Colors.Background()
        let iconSide: CGFloat = 40
        _ = iconView.constrainToLeft(constrainTo: containerView, amount: 20.0)
        _ = iconView.constrainBelow(constrainTo: closeButton, amount: 0.0)
        _ = iconView.constrainWidth(width: iconSide)
        _ = iconView.constrainHeight(height: iconSide)
        self.iconView.layer.cornerRadius = iconSide / 2
        self.iconView.clipsToBounds = true

        _ = titleLabel.constrainLeftToRightOf(constrainInside: self.iconView, offset: 20.0)
        _ = titleLabel.constrainRightToLeftOf(constrainInside: self.closeButton, offset: -10.0)
        _ = titleLabel.constrainBelow(constrainTo: closeButton, amount: -4)
        
        titleLabel.textColor = ANStyleGuideManager.Colors.Title()
        titleLabel.font = ANStyleGuideManager.Fonts.Body.DialogHeadline()

        // pan gesture
        let swipe = UISwipeGestureRecognizer.init(target: self, action: #selector(processSwipe))
        swipe.direction = .down
        self.view.addGestureRecognizer(swipe)
    }
    
    @objc public func processSwipe(gesture: UISwipeGestureRecognizer) {
        if gesture.state == .ended {
            self._dismiss()
        }
    }
    
    private func updateCurrentHeight() {
        
        guard let parent = self.parent else {
            return
        }
        
        parent.view.layoutIfNeeded()
        let bottomPadding : CGFloat = 20.0
        let height = titleLabel.height + self.titleLabel.height + self.contentView.height + bottomPadding + closeButton.height
        
        self.currentHeight = height
    }
    
    public func set(title: String, titleColor : UIColor? = nil) {
        if didSetupViews == false {
            didSetupViews = true
            self.setupViews()
        }
        
        if let titleColor = titleColor {
            titleLabel.textColor = titleColor
        }
        
        titleLabel.text = title
    }
    
    public func setContentView(view: UIView) {
        if didSetupViews == false {
            didSetupViews = true
            self.setupViews()
        }
        
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
        
        contentView.addSubview(view)
        _ = view.constrainFitInside(constrainInside: contentView, insets: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    public func setContentViewLabel(text: String, textColor : UIColor? = nil) {
        if didSetupViews == false {
            didSetupViews = true
            self.setupViews()
        }
        
        for v in contentView.subviews {
            v.removeFromSuperview()
        }
        
        let label = UILabel.init()
        label.font = ANStyleGuideManager.Fonts.Body.Body4()
        label.textColor = textColor != nil ? textColor! : ANStyleGuideManager.Colors.Title()
        label.numberOfLines = 0
        label.text = text
        label.textAlignment = .left
        
        self.contentView.addSubview(label)
        
        _ = label.constrainFitInside(constrainInside: contentView, insets: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -0))
    }
    
    public func setOnDismiss(action: @escaping () -> Void) {
        self.onDismissAction = action
    }
    
    public func show(duration: TimeInterval? = nil) {
        
        guard let parent = self.parent else {
            return
        }
        
        // if a duration is set, clamp it to set min/max and create a timer
        if var duration = duration {
            let max : TimeInterval = 60.0
            let min : TimeInterval = 3.0
            if duration > max {
                duration = max
            } else if duration < min {
                duration = min
            }
            
            self.timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false, block: { (timer: Timer) in
                // dismiss self
                self._dismiss()
            })
        }
        
        self.updateCurrentHeight()
        
        let parentHeight = parent.view.height
        
        _ = self.view.constrainHeight(height: parentHeight, relation: .equal)
        
        parent.view.addSubview(self.view)
        
        let bottomConstraint = self.view.constrainToBottom(constrainTo: parent.view, amount: parentHeight)
        bottomConstraint.identifier = "bottom"
        _ = self.view.constrainToLeft(constrainTo: parent.view)
        _ = self.view.constrainToRight(constrainTo: parent.view)
        //        _ = self.view.constrainHeight(height: self.currentHeight)
        self.view.tag = 456
        parent.view.layoutIfNeeded()
        
        var safeAreaBottom : CGFloat = 0
        if #available(iOS 11.0, *) {
            safeAreaBottom = self.view.safeAreaInsets.bottom
        }
        
        UIView.animate(withDuration: animationDuration, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0.75, options: .beginFromCurrentState, animations: {
            
            let bottomConstraintConstant = parentHeight - self.containerView.height - safeAreaBottom
            bottomConstraint.constant = bottomConstraintConstant
            parent.view.layoutIfNeeded()
        }) { [weak self] (completed: Bool) in

        }
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.resizeAndRelayout()
    }
    
    func resizeAndRelayout(){
        
    }
    
    @objc public func _dismiss() {
        
        guard let parent = self.parent else {
            return
        }
        
        var selectLineView : UIView?
        var selectViewBottomConstraint: NSLayoutConstraint?
        for view in parent.view.subviews {
            if view.tag == 456 {
                selectLineView = view
            }
        }
        
        for constraint in parent.view.constraints {
            if constraint.identifier == "bottom" {
                selectViewBottomConstraint = constraint
            }
        }
        
        guard let selectView = selectLineView, let bottom = selectViewBottomConstraint else {
            return
        }
        
        self.timer?.invalidate()
        
        bottom.constant = selectView.height
        
        UIView.animate(withDuration: animationDuration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .beginFromCurrentState, animations: {
            parent.view.layoutIfNeeded()
            
        }) { [weak self] (completed: Bool) in
            // remove views
            selectView.removeFromSuperview()
            
            // remove child view controller
            var child : UIViewController?
            for _child in parent.children {
                if child == _child {
                    child = _child
                }
            }
            
            if let onDismissAction = self?.onDismissAction {
                onDismissAction()
            }
            
            child?.removeFromParent()
        }
    }
}
