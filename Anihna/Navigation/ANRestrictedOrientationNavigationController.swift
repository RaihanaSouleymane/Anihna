//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.
//
import UIKit


protocol ANAddLineDelegate : class {
    func didAddLine(forSubsciberId subscriberId: String)
    func didCancelAddLine()
}

extension UIImage {
    class func imageWithColor2(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 0.5)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

class ANRestrictedOrientationNavigationController : UINavigationController {
    
    private var restrictOrientation = false
    private var addSettings = false
    var isSettingShowing = false
    var coloredViewTopConstraint : NSLayoutConstraint?

    var coloredView = UIView.init()
    var potraitNavBarHeight: CGFloat = 44
    var landscapeNavBarHeight: CGFloat = 32
    var callingNav = false

    // var shouldSlideToShowMenu: Bool?
    // MARK: - Orientation

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIScreen.main.bounds.size.height == 736 || UIScreen.main.bounds.size.height == 414 { // Deliberately change navigation bar height in lanscape mode in Plus device (6 Plus, 6s Plus, etc)
            landscapeNavBarHeight = 44
        }
        
        self.navigationBar.isTranslucent = false
        self.interactivePopGestureRecognizer?.delegate = nil
        
        self.navigationBar.shadowImage = UIImage.imageWithColor2(color: ANStyleGuideManager.Colors.HorizontalRule)
        addColoredUnderLine()

        NotificationCenter.default.addObserver(self, selector: #selector(logOutNow(note:)), name: Notification.Name.init("logOutNow"), object: nil)
        self.navigationBar.barTintColor = ANStyleGuideManager.Colors.Background()
        self.modalPresentationStyle = .fullScreen
    }

    override func viewDidAppear(_ animated: Bool) {
        //print("navigationController_didShow")
        NotificationCenter.default.post(name:Notification.Name.init("navigationController_DidShow"), object: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
       // print("navigationController_DidDisappear")
        NotificationCenter.default.post(name:Notification.Name.init("navigationController_DidDisappear"), object: nil)
    }

    @objc func logOutNow(note: Notification) {
        if self.presentedViewController != nil {
            if self.presentedViewController is ANRestrictedOrientationNavigationController{
                print("self.presentedViewController")
                let vc = self.presentedViewController!
                vc.dismiss(animated: true, completion: {
                    print("self.presentedViewController dismissed")
                    
                })
            }
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.coloredViewTopConstraint?.constant = size.width > size.height ? landscapeNavBarHeight : potraitNavBarHeight
    }

    func addColoredUnderLine(){
        self.coloredView = UIView(frame: CGRect(x: 0, y: navigationBar.frame.height+20, width: navigationBar.frame.width, height: 2))
        self.coloredView.translatesAutoresizingMaskIntoConstraints = false
        self.coloredView.backgroundColor = UIColor.clear
        self.view.addSubview(self.coloredView)
        let constraintHeight = traitCollection.verticalSizeClass == .compact ? landscapeNavBarHeight : potraitNavBarHeight
        
        coloredViewTopConstraint = coloredView.constrainToTop(constrainTo: self.view, amount: constraintHeight)
        _ = coloredView.constrainToLeft(constrainTo: self.view)
        _ = coloredView.constrainToRight(constrainTo: self.view)
        _ = coloredView.constrainHeight(height: 2)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {

            //This line Lock the rotation
            return .portrait
        }
    }
    
    override var shouldAutorotate: Bool {
        get {
            //This line Lock the rotation
            return false
        }
    }
    
    func restrictOrientation(restrict: Bool) {
        self.restrictOrientation = restrict


        //
        //        if let parent = self.parent as? ANRestrictedTabBarViewController {
        //            parent.restrictOrientation(restrict: restrict)
        //        }
        //
        //        if (traitCollection.userInterfaceIdiom == .phone || traitCollection.userInterfaceIdiom == .unspecified), restrict == true {
        //            let value = UIInterfaceOrientation.portrait.rawValue
        //            UIDevice.current.setValue(value, forKey: "orientation")
        //        }


        //This line Lock the rotation
        if (traitCollection.userInterfaceIdiom == .phone || traitCollection.userInterfaceIdiom == .unspecified) {
            let value = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        }
    }
    
    func addTitleView(viewTitle: String, vc:UIViewController) {
        
        let titleView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 1000, height: 30))
        let label = UILabel.init()
        label.textAlignment = .center
        label.font = ANStyleGuideManager.Fonts.Body.Body3()
        label.textColor = ANStyleGuideManager.Colors.Title()
        label.text = viewTitle
        
        titleView.addSubview(label)
        // _ = label.constrainFitInside(constrainInside: titleView)
        vc.navigationItem.titleView = titleView
    }
    
    func updateColoredView(withColor color: UIColor) {
        self.coloredView.backgroundColor = color
    }
}

extension ANRestrictedOrientationNavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
    
        if callingNav == true {
            return .lightContent
        }

        var status : UIStatusBarStyle = .default
        //.default
        if #available(iOS 12.0, *)  {
            if traitCollection.userInterfaceStyle == .dark {
                status = .lightContent
            }else{}
        } else {
            // Fallback on earlier versions
            status =  .default
        }
        return status
    }
}
