//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.
//

import UIKit

public protocol ANPrimaryPromptViewControllerDelegate : class {
    func closeBttnTapped()
    func primaryPromptDidShow()
    func primaryPromptDidDismiss()
}

open class ANPrimaryPromptViewController: UIViewController {
    static var count = 1400
    static var dimCount = 14000
    
    static func getTag() -> Int {
        let thisTag = count
        count += 1
        return thisTag
    }
    
    static func getDimTag() -> Int {
        let thisTag = dimCount
        dimCount += 1
        return thisTag
    }
    
    public var keyboardPlaceholderView : ANKeyboardPlaceholderView?

    public weak var promptDelegate : ANPrimaryPromptViewControllerDelegate?
    public var currentHeight : CGFloat = 0
    public var buttonHeight : CGFloat = 50
    public var buttonPadding : CGFloat = 10
    public var titleViewHeight: CGFloat = 60 {
        didSet {
            if let constraint = self.titleViewHeightConstraint {
                constraint.constant = titleViewHeight
                
            }
        }
    }

    public var dimView: UIView?
    public let closeButtonView = UIView.init()
    public let closeButton = UIButton.init()

    public let titleView = UIView.init()
    public let titleLabel = UILabel.init()
    public let contentView = UIView.init()
    public let containerView = UIView.init()

    public let sepView = UIView.init()

    public let topRightConerView = UIView.init()
    public let topRightConerImageView = UIImageView.init()
    
    public var addCornerImageView: Bool = false
    public var cornerImageViewImage : UIImage?
    public var backgroundColorHext : String?
    
    public let buttonStackView = UIStackView.init()
    public var buttonStackViewHeightConstraint : NSLayoutConstraint?
    
    var titleViewHeightConstraint : NSLayoutConstraint?
    var bottomConstraint : NSLayoutConstraint?
    
    public var confirmButton : UIButton?
    public var cancelButton : UIButton?
    
    public var confirmButtonAction : (() -> Void)?
    public var cancelButtonAction : (() -> Void)?
    public var closeButtonAction : (() -> Void)?
    public var onDismissAction : (() -> Void)?
    
    public var didSetupViews = false
    
    open var allowTapToDismiss = false
    public var addCloseButton = false
    public var addTitleIcon = false
    public let buttonSize: CGFloat = 24.0

    public let topLeftConerView = UIView.init()
    public let topLeftConerImageView = UIImageView.init()
    public var addLeftCornerImageView: Bool = false
    public var leftCornerImageViewImage : UIImage?

    public convenience init() {
        self.init(nibName:nil, bundle:nil)
        self.setupViews()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        
        if didSetupViews == false {
            didSetupViews = true
            self.setupViews()
        }
    }

    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupViews() {


        
        self.setupTitleView()
        // Do any additional setup after loading the view.
        
        //        self.contentStackView.axis = .vertical
        //        self.contentStackView.distribution = .fillProportionally
        //        self.contentStackView.alignment = .leading
        //        self.contentStackView.spacing = 20
        
        self.buttonStackView.axis = .horizontal
        self.buttonStackView.distribution = .fill
        self.buttonStackView.alignment = .center
        self.buttonStackView.spacing = 8
        
        let buttonStackViewContainer = UIView.init()
        
        self.containerView.backgroundColor = ANStyleGuideManager.Colors.DarkModeGrayBackground()

        buttonStackViewContainer.addSubview(buttonStackView)
        self.view.addSubview(containerView)
        
        _ = buttonStackView.constrainCenterInside(constrainInside: buttonStackViewContainer)
        
        _ = containerView.constrainToTop(constrainTo: self.view)
        _ = containerView.constrainToLeft(constrainTo: self.view)
        _ = containerView.constrainToRight(constrainTo: self.view)
        
        containerView.addSubview(contentView)
        _ = self.contentView.constrainBelow(constrainTo: titleView, amount: 0)
        _ = self.contentView.constrainToLeft(constrainTo: containerView, amount: 0)
        _ = self.contentView.constrainToRight(constrainTo: containerView, amount: 0)
        //        _ = self.contentStackView.constrainHeight(height: 200)
        
        containerView.addSubview(buttonStackViewContainer)
        _ = buttonStackViewContainer.constrainBelow(constrainTo: contentView, amount: 10)
        _ = buttonStackViewContainer.constrainToLeft(constrainTo: containerView, amount: 20)
        _ = buttonStackViewContainer.constrainToRight(constrainTo: containerView, amount: 20)
        _ = buttonStackViewContainer.constrainToBottom(constrainTo: containerView, amount: -20)
        _ = buttonStackView.constrainHeightToParent(parent: buttonStackViewContainer, percentage: 1.0)
        buttonStackViewHeightConstraint = buttonStackViewContainer.constrainHeight(height: 0)
        
        if addCloseButton{
            containerView.addSubview(closeButtonView)
            // close button
            closeButton.setImage(UIImage.init(named: "Icon - Close - Black")?.withRenderingMode(.alwaysTemplate), for: .normal)
            closeButton.tintColor = ANStyleGuideManager.Colors.Icon()

            let tap = UITapGestureRecognizer.init(target: self, action: #selector(_dismiss))
            closeButtonView.addGestureRecognizer(tap)
            closeButton.isUserInteractionEnabled = false
            
//            _ = closeButton.constrainWidth(width: buttonSize)
//            _ = closeButton.constrainHeight(height: buttonSize)
            closeButtonView.addSubview(closeButton)
            _ = closeButton.constrainFitInside(constrainInside: closeButtonView)//, insets: UIEdgeInsets.init(top: 10, left: 10, bottom: -10, right: -10))
            _ = closeButtonView.constrainToTop(constrainTo: self.containerView, amount: 10.0)
            _ = closeButtonView.constrainToRight(constrainTo: self.containerView, amount: 16.0)
            _ = closeButtonView.constrainHeight(height: buttonSize)
            _ = closeButtonView.constrainWidth(width:buttonSize)

            
        }
    }

    public func updateBackgroundColor(withColor: String){
        self.backgroundColorHext = withColor
        self.topRightConerView.backgroundColor = UIColor.init(hexString: withColor)

    }
    
    private func setupTitleView() {
        self.titleView.addSubview(titleLabel)
        titleLabel.adjustsFontSizeToFitWidth = true

        if addLeftCornerImageView {
                _ = titleLabel.constrainFitInside(constrainInside: titleView, insets: UIEdgeInsets.init(top: 0, left: 52, bottom: 0, right: -20))
        }else{
                _ = titleLabel.constrainFitInside(constrainInside: titleView, insets: UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: -20))
        }

        self.titleView.addSubview(sepView)

        _ = sepView.constrainBelow(constrainTo: self.titleLabel,amount: -10)
        _ = sepView.constrainToLeft(constrainTo: self.titleView, amount: 20.0)
        _ = sepView.constrainToRight(constrainTo: self.titleView, amount: 20.0)
        _ = sepView.constrainHeight(height: 3.0)
        sepView.backgroundColor = ANStyleGuideManager.Colors.Title()
        
        containerView.addSubview(titleView)
        self.titleViewHeightConstraint = titleView.constrainHeight(height: titleViewHeight)
        _ = titleView.constrainToLeft(constrainTo: containerView)
        _ = titleView.constrainToRight(constrainTo: containerView)
        _ = titleView.constrainToTop(constrainTo: containerView)
        
        titleLabel.textColor = ANStyleGuideManager.Colors.Title()
        titleLabel.font = ANStyleGuideManager.Fonts.Body.DialogHeadline()

        if addCornerImageView {
            self.titleView.addSubview(self.topRightConerView)
            _ = topRightConerView.constrainHeight(height:titleViewHeight/2)
            _ = topRightConerView.constrainWidth(width: titleViewHeight/2)
            _ = topRightConerView.constrainToRight(constrainTo: titleView, amount: 20)
            _ = topRightConerView.constrainYCenter(to: titleView)
            
            topRightConerView.backgroundColor = ANStyleGuideManager.Colors.Clear //CoolGray6
            topRightConerView.layer.cornerRadius = titleViewHeight/4
            
            topRightConerView.addSubview(self.topRightConerImageView)
            _ = topRightConerImageView.constrainFitInside(constrainInside: topRightConerView)
            
            if let cornerViewImage = self.cornerImageViewImage {
                topRightConerImageView.image = cornerViewImage
                topRightConerView.clipsToBounds = true
            }
          if let cornerViewBackground = self.backgroundColorHext {
                topRightConerImageView.backgroundColor = UIColor.clear
                updateBackgroundColor(withColor: cornerViewBackground)
            }
        }


        if addLeftCornerImageView {
            self.titleView.addSubview(self.topLeftConerView)
            _ = topLeftConerView.constrainHeight(height: buttonSize)//titleViewHeight/2)
            _ = topLeftConerView.constrainWidth(width: buttonSize)//titleViewHeight/2)
            _ = topLeftConerView.constrainToLeft(constrainTo: titleView, amount: 20)
            _ = topLeftConerView.constrainYCenter(to: titleView)

            topLeftConerView.backgroundColor = ANStyleGuideManager.Colors.Clear //CoolGray6
            //topRightConerView.layer.cornerRadius = titleViewHeight/4

            topLeftConerView.addSubview(self.topLeftConerImageView)
            _ = topLeftConerImageView.constrainFitInside(constrainInside: topLeftConerView)

            if let cornerViewImage = self.leftCornerImageViewImage {
                topLeftConerImageView.image = cornerViewImage
                topLeftConerView.clipsToBounds = true
            }
            if let cornerViewBackground = self.backgroundColorHext {
                topLeftConerImageView.backgroundColor = UIColor.clear
                updateBackgroundColor(withColor: cornerViewBackground)
            }
        }
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    public func setContentView(view: UIView) {
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
        
        contentView.addSubview(view)
        _ = view.constrainFitInside(constrainInside: contentView, insets: UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: -20))

        self.addKeyboardPlaceholder(toView: view)
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
        label.numberOfLines = 0

       // let range = (text as NSString).range(of: "\(Appname.appname)")
        let ranges = text.nsRanges(of: "Continuous Auth")
        let attribute = NSMutableAttributedString.init(string: text)
        attribute.addAttributes([NSAttributedString.Key.font: ANStyleGuideManager.Fonts.Body.Body4(), NSAttributedString.Key.foregroundColor:ANStyleGuideManager.Colors.Title()], range: NSMakeRange(0, attribute.length))
        for range in ranges {
            attribute.addAttributes([NSAttributedString.Key.font: ANStyleGuideManager.Fonts.Body.Body1(), NSAttributedString.Key.foregroundColor:ANStyleGuideManager.Colors.Title()], range: range)
        }

        label.attributedText = attribute

        self.contentView.addSubview(label)
        
        _ = label.constrainFitInside(constrainInside: contentView, insets: UIEdgeInsets.init(top: 0, left: 20, bottom: -20, right: -20))
    }
    
    public func setConfirmationButton(title: String, startEnabled : Bool = true, action: @escaping () -> Void) {
        
        if didSetupViews == false {
            didSetupViews = true
            self.setupViews()
        }
        
        if confirmButton != nil {
            buttonStackView.removeArrangedSubview(confirmButton!)
            confirmButton!.removeFromSuperview()
        }
        
        confirmButton = ANBorderlessDialogButton.init(foregroundColor: ANStyleGuideManager.Colors.InvertedTitle(), backgroundColor: ANStyleGuideManager.Colors.InvertedBackground())
        confirmButton!.setTitle(title, for: .normal)
        confirmButton?.isEnabled = startEnabled
        
        buttonStackView.addArrangedSubview(confirmButton!)
        
        self.buttonStackViewHeightConstraint?.constant = ANDialogSmallButton.ButtonHeight + (buttonPadding * 2)
        _ = self.confirmButton?.constrainHeight(height: buttonHeight)
        _ = confirmButton?.constrainWidth(width: ButtonWidth())
        
        confirmButton?.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        confirmButtonAction = action
        
        self.view.layoutIfNeeded()
    }
    
    public func setCancelButton(title: String, action: @escaping () -> Void) {


        if didSetupViews == false {
            didSetupViews = true
            self.setupViews()
        }
        
        if cancelButton != nil {
            buttonStackView.removeArrangedSubview(cancelButton!)
            cancelButton!.removeFromSuperview()
        }
        
        cancelButton = ANHollowButton.init(foregroundColor: ANStyleGuideManager.Colors.Title())
        cancelButton!.setTitle(title, for: .normal)
        cancelButton!.clipsToBounds = true

        buttonStackView.addArrangedSubview(cancelButton!)
        
        self.buttonStackViewHeightConstraint?.constant = ANDialogSmallButton.ButtonHeight + (buttonPadding * 2)
        _ = cancelButton?.constrainWidth(width: ButtonWidth())
        
        cancelButton?.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        cancelButtonAction = action
        
        self.view.layoutIfNeeded()
    }
    
    func ButtonWidth() -> CGFloat {
        return (self.view.width - 16 - 16 - 8) / 2
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
    
    private func updateCurrentHeight() {
        
        guard let parent = self.parent else {
            return
        }
        
        parent.view.layoutIfNeeded()
        
        var height = titleLabel.height + titleViewHeight + self.contentView.height
        
        if let buttonStackHeight = buttonStackViewHeightConstraint?.constant {
            height += buttonStackHeight
        }
        
        self.currentHeight = height
    }
    
    public func show(bottomOffset: CGFloat? = nil) {
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        self.view.tag = ANPrimaryPromptViewController.getTag()
        
        
        guard let parent = self.parent else {
            return
        }
        
        self.updateCurrentHeight()
        
        let parentHeight = parent.view.height
        
        _ = self.view.constrainHeight(height: parentHeight, relation: .equal)
        
        // dimView
        let dimView = UIView.init()
        dimView.backgroundColor = ANStyleGuideManager.Colors.Black
        dimView.alpha = 0.0
        dimView.tag = ANPrimaryPromptViewController.getDimTag()
        parent.view.addSubview(dimView)
        _ = dimView.constrainFitInside(constrainInside: parent.view)
        self.dimView = dimView
        
        parent.view.addSubview(self.view)

        bottomConstraint = self.view.constrainToBottom(constrainTo: parent.view, amount: parentHeight)
        bottomConstraint?.identifier = "bottom"
        _ = self.view.constrainToLeft(constrainTo: parent.view)
        _ = self.view.constrainToRight(constrainTo: parent.view)
//        _ = self.view.constrainHeight(height: self.currentHeight)
        self.view.layer.zPosition = 100000
        parent.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0.75, options: .beginFromCurrentState, animations: {
            self.bottomConstraint?.constant = parentHeight - self.containerView.height // - _bottomOffset
            parent.view.layoutIfNeeded()

            dimView.alpha = 0.6
            
        }) { [weak self] (completed: Bool) in
            
            if self == nil {
                return
            }
            
            if self!.allowTapToDismiss {
                let dismissButton = UIButton.init()
                dismissButton.addTarget(self!, action: #selector(self!._dismiss), for: .touchUpInside)
                dimView.addSubview(dismissButton)
                _ = dismissButton.constrainFitInside(constrainInside: dimView)
            }
        }
    }


    public func showOnWindow(viewController: UIViewController, bottomOffset: CGFloat? = nil){

        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        self.view.tag = ANPrimaryPromptViewController.getTag()
        let parent = viewController

        self.updateCurrentHeight()

        let parentHeight = parent.view.height

        _ = self.view.constrainHeight(height: parentHeight, relation: .equal)

        // dimView
        let dimView = UIView.init()
        dimView.backgroundColor = ANStyleGuideManager.Colors.Black
        dimView.alpha = 0.0
        dimView.tag = ANPrimaryPromptViewController.getDimTag()
        parent.view.addSubview(dimView)
        _ = dimView.constrainFitInside(constrainInside: parent.view)
        self.dimView = dimView

        parent.view.addSubview(self.view)

        let bottomConstraint = self.view.constrainToBottom(constrainTo: parent.view, amount: parentHeight)
        bottomConstraint.identifier = "bottom"
        _ = self.view.constrainToLeft(constrainTo: parent.view)
        _ = self.view.constrainToRight(constrainTo: parent.view)
        //        _ = self.view.constrainHeight(height: self.currentHeight)
        self.view.layer.zPosition = 100000
        parent.view.layoutIfNeeded()

        UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0.75, options: .beginFromCurrentState, animations: {
            bottomConstraint.constant = parentHeight - self.containerView.height // - _bottomOffset
            parent.view.layoutIfNeeded()
        
            dimView.alpha = 0.6

        }) { [weak self] (completed: Bool) in

            if self == nil {
                return
            }

            if self!.allowTapToDismiss {
                let dismissButton = UIButton.init()
                dismissButton.addTarget(self!, action: #selector(self!._dismiss), for: .touchUpInside)
                dimView.addSubview(dismissButton)
                _ = dismissButton.constrainFitInside(constrainInside: dimView)
            }
        }
    }

    @objc public func _dismiss() {
        
        guard let parent = self.parent else {
            return
        }
        
        // remove dim view
        var selectLineView : UIView?
        var selectViewBottomConstraint: NSLayoutConstraint?
        for view in parent.view.subviews {
            if view.tag == dimView!.tag {
                dimView = view
            } else if view.tag == self.view.tag {
                selectLineView = view
            }
        }
        
        for constraint in parent.view.constraints {
            if constraint.identifier == "bottom" {
                selectViewBottomConstraint = constraint
            }
        }
        
        guard let _dimView = dimView, let selectView = selectLineView, let bottom = selectViewBottomConstraint else {
            return
        }
        
        bottom.constant = selectView.height + 40 // account for extra offset due to safe areas
        
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .beginFromCurrentState, animations: {
            parent.view.layoutIfNeeded()
            _dimView.alpha = 0.0

        }) { [weak self] (completed: Bool) in
            // remove views
            _dimView.removeFromSuperview()
            selectView.removeFromSuperview()
            
            // remove child view controller
            var child : UIViewController?
            for _child in parent.children {
                if let _ = _child as? ANPrimaryPromptViewController {
                    child = _child
                }
            }

            if let onDismissAction = self?.onDismissAction {
                onDismissAction()
            } else {
                print("no dismiss action?")
                self?.closeButtonAction?()
                self?.promptDelegate?.closeBttnTapped()
            }
            
            if let child = child {
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
            }
        }
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    open func setOnDismiss(action: @escaping () -> Void) {
        self.onDismissAction = action
    }
    
    @objc open func confirmButtonTapped() {
        confirmButtonAction?()
    }
    
    @objc open func cancelButtonTapped() {
        cancelButtonAction?()
    }
    
    @objc open func closeButtonTapped() {
        closeButtonAction?()
        self.promptDelegate?.closeBttnTapped()
    }
}

public extension ANPrimaryPromptViewController {
    func updateShowingOffset() {
        guard let dimView = self.dimView, let parent = self.parent else {
            return
        }
        
        parent.view.layoutIfNeeded()
        
        let parentHeight = parent.view.height
        self.bottomConstraint?.constant = parentHeight - self.containerView.height // - _bottomOffset
        
        UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0.75, options: .beginFromCurrentState, animations: {
            parent.view.layoutIfNeeded()
            dimView.alpha = 0.6
            
        }) { (completed: Bool) in
        }
    }
    
    func addKeyboardPlaceholder(toView view: UIView) {
        keyboardPlaceholderView = ANKeyboardPlaceholderView.init(frame: CGRect.init(x: 0, y: 0, width:  view.bounds.width, height: view.bounds.height))
        keyboardPlaceholderView?.isUserInteractionEnabled = false
        
        var textField : UITextField?
        
        if let stackView = view as? UIStackView {
            
            for arrangedView in stackView.arrangedSubviews {
                if let tf = arrangedView as? UITextField {
                    textField = tf
                    break
                }
                
                for subview in arrangedView.subviews {
                    if let tf = subview as? UITextField {
                        textField = tf
                        break
                    }
                }
            }
        } else {
            for subview in view.subviews {
                if let tf = subview as? UITextField {
                    textField = tf
                    break
                }
            }
        }        
        
        if let textField = textField {
            textField.inputAccessoryView = keyboardPlaceholderView
            
            keyboardPlaceholderView?.inputAccessoryViewFrameChanged =  { [weak self] (rect:CGRect) in
                
                if self != nil {
                    var navBarOffset : CGFloat = 0
                    if let offset = self?.navigationController?.navigationBar.frame.height {
                        navBarOffset = offset
                    }
                    
                    let bottomInset = self!.view.safeAreaInsets.bottom
                    let value : CGFloat = self!.view.frame.height + UIApplication.shared.statusBarFrame.height +
                        navBarOffset - (textField.inputAccessoryView?.superview?.frame.minY)! - textField.inputAccessoryView!.frame.size.height - bottomInset
                    
                    let newBottomConstant = CGFloat.maximum(0, value)
                    self?.bottomConstraint!.constant = -newBottomConstant
                    self?.view.layoutIfNeeded()
                }
            }
        }
    }
}
