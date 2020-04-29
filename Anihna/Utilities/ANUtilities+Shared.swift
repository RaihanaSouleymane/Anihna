//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.


import UIKit

extension ANUtilities {
    class func openBrowser(withUrl url: String){
        let url = URL(string: url)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
