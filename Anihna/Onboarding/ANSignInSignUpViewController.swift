//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.
//

import UIKit


protocol ANSignInSignUpViewControllerDelegate : class {
    func didLogIn()
}



class ANSignInSignUpViewController: UIViewController{
     weak var delegate : ANSignInSignUpViewControllerDelegate?

    @IBOutlet weak var buttonView: UIView!

    @IBOutlet weak var confirmationButtonView: ANBlackConfirmationButtonView!


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmationButtonView.backgroundColor = UIColor.clear
        self.confirmationButtonView.isHidden = false
        self.confirmationButtonView.enable()

        self.confirmationButtonView.button.setTitle("Login", for: .normal)
            self.confirmationButtonView.button.addTarget(self, action: #selector(loginButtonClicked(_:)), for: .touchUpInside)
}

    @objc func loginButtonClicked(_ sender: Any) {
        (self.navigationController as? ANOnboardingNavigationController)?.dismiss(animated: true) {
              AppDelegate.shared.tabViewController.set(visibleTab: .map)
            self.delegate?.didLogIn()
            }
      }
}
