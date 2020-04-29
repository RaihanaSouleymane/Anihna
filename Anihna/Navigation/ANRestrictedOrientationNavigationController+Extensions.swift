//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.
//

import Foundation

extension ANRestrictedOrientationNavigationController : ANOnboardingDelegate {
    // MARK: - ANOnboardingDelegate
    func dismissOnBoardingViewController(didAddNewLine: Bool) {
        if self.presentedViewController != nil {
            self.dismiss(animated: true, completion: {
                
            })
        } else {
            ANSideMenuViewController.shared?.changeViewController(.profile)
        }
    }
    
    func dismissOnBoardingViewControllerWithNotification(didAddNewLine: Bool, disableImessageNotification: Bool) {
        self.dismiss(animated: true, completion: {
            
        })
    }
}

extension ANRestrictedOrientationNavigationController : ANAddLineDelegate {
    func didAddLine(forSubsciberId subscriberId: String) {
        
        func dismissProvisioning() {
            self.dismissOnBoardingViewController(didAddNewLine: true)
        }
        
        dismissProvisioning()
    }
    
    func didCancelAddLine(){
        self.dismiss(animated: true, completion: nil)
        
    }
}
