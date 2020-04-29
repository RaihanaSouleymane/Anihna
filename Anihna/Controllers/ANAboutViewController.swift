//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.
//

import Foundation
import UIKit


enum aboutOptions : Int {
    case fAQ = 1
    case termCond
    case privPolicy
    case openSource

}
class ANAboutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView  =   UITableView()
    var itemsToLoad: [String] = ["FAQs", "Terms & conditions", "Privacy policy", "Third party notices", "App version: 1.0"]
    var timesTappedAboutButton = 0
    let MaxTapsToNotifyUserOfLoggingMode = 5
    let MaxTapsToActivateLogging = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         self.navigationItem.titleView = ANNavigationBarTitleViewFactory.standardTitleView(withTitle: "About")
        // right BBI
        self.addCloseButton(target: #selector(ANAboutViewController.closeButtonTapped), position: 1)
        (self.navigationController as? ANRestrictedOrientationNavigationController)?.restrictOrientation(restrict: true)
    }

    @objc func closeButtonTapped(){
        self.dismissViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = ANStyleGuideManager.Colors.InvertedCoolGrays()
        // Get main screen bounds
        let screenSize: CGRect = UIScreen.main.bounds

        let screenWidth = screenSize.width
        let screenHeight = screenSize.height

        tableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        self.tableView.backgroundColor = ANStyleGuideManager.Colors.Clear

        self.view.addSubview(tableView)
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsToLoad.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath)

        cell.textLabel?.text = self.itemsToLoad[indexPath.row]
        cell.selectionStyle = .none
        cell.textLabel?.font = ANStyleGuideManager.Fonts.Buttons.Big()
        var rect = CGRect(x:16, y:  cell.contentView.height - 1.0, width: self.tableView.width - 32, height:1.0)
        if indexPath.row == 4 {
           // cell.accessoryType = .disclosureIndicator
             rect = CGRect(x:0, y:  cell.contentView.height - 1.0, width: self.tableView.width, height:1.0)
        }
        cell.contentView.layer.addBorder(edge: .bottom, color: ANStyleGuideManager.Colors.HorizontalRule, thickness: 1, rect: rect)
        
        if self.itemsToLoad[indexPath.row].hasPrefix("App version") {
            // no carets
        } else {
            // check for view with tag
            var hasCaret = false
            for v in cell.subviews {
                if v.tag == 123 {
                    hasCaret = true
                    break
                }
            }
            
            if hasCaret == false {
                let caretAccessoryView = UIImageView.init()
                cell.contentView.addSubview(caretAccessoryView)
                // caret view
                let caretSide: CGFloat = 25
                let caretImage = UIImage.init(named: "Icon - Carat Down- - Black")!.withRenderingMode(.alwaysTemplate)
                caretAccessoryView.tintColor = ANStyleGuideManager.Colors.Icon()
                caretAccessoryView.image = caretImage
                caretAccessoryView.tag = 123
                caretAccessoryView.transform = CGAffineTransform.init(rotationAngle: 3.14 * 1.5)
                _ = caretAccessoryView.constrainToRight(constrainTo: cell.contentView, amount: 20)
                _ = caretAccessoryView.constrainYCenter(to: cell.contentView)
                _ = caretAccessoryView.constrainWidth(width: caretSide)
                _ = caretAccessoryView.constrainHeight(height: caretSide)
            }
        }

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("User selected table row \(indexPath.row) and item \(itemsToLoad[indexPath.row])")

        switch indexPath.row {
        case 0:
            self.goToBrowser(withUrl: FAQConstants.faqUrlConstants, isFAQ: true)

        case 1:
            self.goToBrowser(withUrl: TermsConditionsConstants.urlConstants, isFAQ: false)
        case 2:
            self.goToBrowser(withUrl: PrivacyPolicyConstants.urlConstants, isFAQ: false)

        case 3:
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ANOpenSourceTableViewController") as! ANOpenSourceTableViewController

            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            break
            
        }

    }

    func goToBrowser(withUrl:String, isFAQ: Bool) {
        ANUtilities.openBrowser(withUrl: withUrl)
    }
}
