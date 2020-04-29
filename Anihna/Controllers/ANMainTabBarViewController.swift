//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.
//
import UIKit
import MessageUI

class ANMainTabBarViewController: ANRestrictedTabBarViewController {

    
    var timer: Timer?
    
    static var animationDuration: TimeInterval = 0.4
    var timerDuration : TimeInterval = 3.0


    
    override var selectedIndex: Int {
        didSet {

        }
    }
    
    enum TabType : Int {
        case map
        case list
    }
    
    deinit {

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = ANStyleGuideManager.Colors.Theme
        if let items = tabBar.items {
            for item in items {
                item.imageInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
            }
        }
        
//        self.tabBar.backgroundImage = UIImage.imageWithColor(color: UIColor.white, alpha: 1.0)
        let borderColor = ANStyleGuideManager.Colors.HorizontalRule
        self.tabBar.layer.addBorder(edge: .top, color: borderColor, thickness: 0.5)
        self.tabBar.clipsToBounds = true
        self.tabBar.shadowImage = nil
        
        self.delegate = self


        self.tabBar.unselectedItemTintColor = ANStyleGuideManager.Colors.Title()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func set(visibleTab : TabType) {
        
        guard let vcs = viewControllers else {
            return
        }
        
        var tabIndex: Int?

        switch visibleTab {
        case .list:
            for (index, vc) in vcs.enumerated() {
                if let nav = vc as? ANRestrictedOrientationNavigationController, let _ = nav.viewControllers.first as? ANListViewControler {
                    tabIndex = index
                    break
                }
            }
            break

        case .map:
            for (index, vc) in vcs.enumerated() {
                if let nav = vc as? ANRestrictedOrientationNavigationController, let _ = nav.viewControllers.first as? ANMapViewControler {
                    tabIndex = index
                    break
                }
            }
            break

        }
        
        if let index = tabIndex {
            self.selectedIndex = index
        }
    }
    


    public func rotation(isRestricted:Bool) {

    }
    

    func conversationListVC() -> ANMapViewControler? {
        
        guard let vcs = viewControllers else {
            return nil
        }
        
        var listVc : ANMapViewControler?
        
        for (_, vc) in vcs.enumerated() {
            if let nav = vc as? ANRestrictedOrientationNavigationController, let ANMapViewControler = nav.viewControllers.first as? ANMapViewControler {
                listVc = ANMapViewControler
                break
            }
        }
        
        return listVc
    }
    


}

extension ANMainTabBarViewController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let should = true
        
        if ((viewController as? UINavigationController)?.topViewController as? ANMapViewControler) != nil {

        }
        
        return should
    }
}






extension ANMainTabBarViewController : MFMailComposeViewControllerDelegate {

    func emailFeedback() {

        guard MFMailComposeViewController.canSendMail() else {
            AppDelegate.shared.window?.rootViewController?.showSnackbarMessage(text: "Please make sure your device can send email, then try again.",isFaillureMessage: true)
            return
        }


        _ = " (\(UIDevice.current.systemVersion))"

        _ = "App name: Anihna"

        
        var body = "Please provide your feedback:"

        body.append("\n\n\n\n")

        body.append("\n")
        body.append(UIDevice.current.systemVersion)
        body.append("\n")


        let mailComposer = MFMailComposeViewController.init()
        mailComposer.mailComposeDelegate = self
        mailComposer.setSubject("iOS " + "Anihna" + " Feedback: version 1.0" )
        mailComposer.setMessageBody(body, isHTML: false)
        mailComposer.setToRecipients(["anihna.service@gmail.com"])

        self.present(mailComposer, animated: true) {

        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismissViewController()
    }
}

extension UIViewController {

    func showSnackbarMessage(text: String, isFaillureMessage: Bool? = false) {

        var targetVC : UIViewController

        if let secondTier = self.presentedViewController?.presentedViewController {
            targetVC = secondTier
        } else if let firstTier = self.presentedViewController {
            targetVC = firstTier
        } else {
            targetVC = self
        }

        let view = UIView.init()
        view.layer.zPosition = 1000
        view.alpha = 0.0
        if isFaillureMessage ==  true  {
            view.backgroundColor = ANStyleGuideManager.Colors.Orange
        }else {
            view.backgroundColor = ANStyleGuideManager.Colors.CallToAction
        }

        let label = UILabel.init()
        label.font = ANStyleGuideManager.Fonts.Body.Body3()
        label.textColor = UIColor.white
        label.text = text
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true

        view.addSubview(label)
        _ = label.constrainFitInside(constrainInside: view, insets: UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: -20))

        let height : CGFloat = 50.0

        targetVC.view.addSubview(view)
        _ = view.constrainToLeft(constrainTo: targetVC.view)
        _ = view.constrainToRight(constrainTo: targetVC.view)
        let top = view.constrainBelow(constrainTo: targetVC.view, amount: 0)
        _ = view.constrainHeight(height: height)

        targetVC.view.layoutIfNeeded()
        top.constant = -height

        UIView.animate(withDuration: 0.5, animations: {
            targetVC.view.layoutIfNeeded()
            view.alpha = 1.0
        }) { (completed: Bool) in
            Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false, block: { (timer: Timer) in
                top.constant = 0
                UIView.animate(withDuration: 0.5, animations: {
                    targetVC.view.layoutIfNeeded()
                    view.alpha = 0.0
                }) { (completed: Bool) in
                    view.removeFromSuperview()
                }
            })
        }
    }
}
