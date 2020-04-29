//
//  AppDelegate.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var dictionaryConstraints = [NSString : NSArray]();
    
    let appName = "Anihna"
    var window: UIWindow?

    var isAppFullyInitialized = false

    static var shared : AppDelegate!
    var keyboradIsVisible = false
    var keyboardHeightWhenVisible : CGFloat = 0
    var alertController: UIAlertController?
    var isLoggedIn = false

    var tabViewController: ANMainTabBarViewController {
        get {
            for vc in (window!.rootViewController as! ContainerViewController).children {
                if vc is ANMainTabBarViewController {
                    return vc as! ANMainTabBarViewController
                }
            }
            return ANMainTabBarViewController()
        }
    }

    var sideM : ANSideMenuViewController{
        get {
            let sideMenu = (window?.rootViewController as! ContainerViewController).leftViewController as! ANSideMenuViewController
            return sideMenu
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        AppDelegate.shared = self

        let state = UIApplication.shared.applicationState
        if state == .background {

            NSLog(" App awoken in background")

        } else {
            NSLog("App awoken with state: \(UIApplication.shared.applicationState.rawValue)")
            if state == .inactive{
                if #available(iOS 12.0, *) {

                }else{
                    
                }
            }
        }
        
        if #available(iOS 13.0, *) {
            }



        return true
    }

    @objc func didShow(notification:NSNotification) {
        print("keybord is visible")
        if let keyboardRectValue = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeightWhenVisible = keyboardRectValue.height
        }
    }

    @objc func willShow(notification:NSNotification) {
        self.keyboradIsVisible = true

    }
    @objc func didHide(){
        print("keybord is not visible")
        self.keyboradIsVisible = false
        keyboardHeightWhenVisible = 0
    }


    
    @objc func initiateNativeMessage(note: Notification) {
        if let str = note.userInfo?["openString"] as? String, let URL = URL.init(string: str) {
            UIApplication.shared.open(URL, options: [:]) { (done: Bool) in
            }
        }
    }
    

    func requestAppReview() {
         print("requestAppReview")
       // SKStoreReviewController.requestReview()

    }
    func presentAppRatingIfNeeded (currentPoint: Int? = nil){
        func go(point: Int){
//            if point <= 0 {
//                 ANAppSettings.updateAppRatingSchedule(scheduleToShow: true)
//                var isRatingPopupVisible: Bool?
//                isRatingPopupVisible =  UserDefaults.standard.value(forKey: "_RatingPopupVisible") as? Bool
//                if ((ANCallManager.shared.activeCallVC?.callConfigIds.isEmpty ?? true) && isRatingPopupVisible == false) {
//                    self.showPreAppRatingPop()
//                }
//            }
        }
//Removing the appRating pop up but keeping the logic, waiting on apptentive

//        if let point = currentPoint {
//            go(point: point)
//        }else{
//            go(point: ANAppSettings.fetchAppRatingCounter())
//        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        }


    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

        if isLoggedIn == false {
          //  sideM.presentAddVirtualLineFromMenu(firstTimeProvision: false)
        } else {


            }

        self.presentAppRatingIfNeeded()

    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.

    }

    func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        var go = false
        if userActivityType == "INStartAudioCallIntent" {
            go = true
        }
        
        return go
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return true
    }

}

extension AppDelegate : UISplitViewControllerDelegate {

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let _ = secondaryViewController as? UINavigationController else { return false }
        return true
    }
}

extension UIApplication {
    
    /// Returns the status bar UIView
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}



//All other Permision
extension AppDelegate {

   
    @objc func _resignFirstResponder(notification: NSNotification) {
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension UIDevice {
    static var isIphoneX: Bool {
        var modelIdentifier = ""
        if isSimulator {
            modelIdentifier = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] ?? ""
        } else {
            var size = 0
            sysctlbyname("hw.machine", nil, &size, nil, 0)
            var machine = [CChar](repeating: 0, count: size)
            sysctlbyname("hw.machine", &machine, &size, nil, 0)
            modelIdentifier = String(cString: machine)
        }
        
        return modelIdentifier == "iPhone10,3" || modelIdentifier == "iPhone10,6" || modelIdentifier == "iPhone11,2" || modelIdentifier == "iPhone11,4" || modelIdentifier == "iPhone11,6" || modelIdentifier == "iPhone11,8"
    }

    static func modelIdentifier () -> String {
        var _modelIdentifier = ""
        if isSimulator {
            _modelIdentifier = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] ?? ""
        } else {
            var size = 0
            sysctlbyname("hw.machine", nil, &size, nil, 0)
            var machine = [CChar](repeating: 0, count: size)
            sysctlbyname("hw.machine", &machine, &size, nil, 0)
            _modelIdentifier = String(cString: machine)
        }
        return _modelIdentifier
    }
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}

extension AppDelegate {
    
    func application(_ application: UIApplication, willChangeStatusBarFrame newStatusBarFrame: CGRect) {
        if let window = self.window, newStatusBarFrame.size.height < 40 {
            UIView.animate(withDuration: 0.35, animations: {
                window.subviews.forEach({ $0.frame = window.bounds })
            })
        }
    }
    
    func application(_ application: UIApplication, didChangeStatusBarFrame oldStatusBarFrame: CGRect) {
        if let window = self.window, oldStatusBarFrame.size.height > 20 {
            UIView.animate(withDuration: 0.35, animations: {
                window.subviews.forEach({ $0.frame = window.bounds })
            })
        }
    }

}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}



