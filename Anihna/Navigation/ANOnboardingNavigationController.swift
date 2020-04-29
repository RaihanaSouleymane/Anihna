//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.
//
import UIKit

protocol ANOnboardingDelegate : class {
    func dismissOnBoardingViewController(didAddNewLine: Bool)
    func dismissOnBoardingViewControllerWithNotification(didAddNewLine: Bool, disableImessageNotification: Bool)
}

class ANOnboardingNavigationController: UINavigationController {
    
    weak var primaryProvisionDelegate : ANSignInSignUpViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.isTranslucent = false
        self.interactivePopGestureRecognizer?.delegate = nil
        self.navigationBar.shadowImage = UIImage.imageWithColor2(color: ANStyleGuideManager.Colors.HorizontalRule)
        self.navigationBar.barTintColor = ANStyleGuideManager.Colors.Background()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

    // MARK: - Orientation
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
    override var shouldAutorotate: Bool {
        get {
            return false
        }
    }


}
