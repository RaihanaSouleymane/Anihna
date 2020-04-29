 //
 //  UIVIewController.swift
 //  Anihna
 //
 //  Created by Raihana Souleymane on 4/26/20.
 //  Copyright © 2020 Raihana Souleymane. All rights reserved.
 //

import UIKit
 

class ANRestrictedTabBarViewController: UITabBarController {
    
    private var restrictOrientation = false // default
     var isEmpty = false
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            //lock rotation
            return .portrait
        }
    }
    
    override var shouldAutorotate: Bool {
        get {
             //lock rotation
            return false
        }
    }
    func isOnEmptyPage(value:Bool){
        isEmpty = value
    }
    func restrictOrientation(restrict: Bool) {

        self.restrictOrientation = restrict

        if traitCollection.userInterfaceIdiom == .phone {
            let value = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register for ContactStore's storeDidChange notifications.
       // NotificationCenter.default.addObserver(self, selector: #selector(ANRestrictedTabBarViewController.handleStoreDidChangeNotification(_:)), name: NSNotification.Name(rawValue: "storeDidChange"), object: ANContactManager.shared)
        // Do any additional setup after loading the view.
    }

    // MARK: - Handle storeDidChangeNotification
    
    @objc func handleStoreDidChangeNotification(_ notification: Notification) {
        //Import all contacts

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item, item.accessibilityElementCount(), self.selectedIndex, item.tag)
        isEmpty = false
        if item.tag == 2 {
            self.selectedIndex = 2
            restrictOrientation(restrict: true)
        }

    }

    deinit {
        // TODO: Move this to another place
        //Unregister for the storeDidChange notification.
       // NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "storeDidChange"), object: ANContactManager.shared)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
