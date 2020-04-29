//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.


import UIKit

enum nextViewTyp : String {
    case profile = "Manage Profile"
    case search = "Search"
    case about = "About"
    case feedback = "Email Feedback"
    case signOut = "Log Out"
    case appversion = "App version"
}



protocol ANSideMenuViewControllerDelegate : class {
    func changeViewController(_ menu: nextViewTyp)
}


class ANSideMenuViewController: UIViewController, ANSideMenuViewControllerDelegate{
    @IBOutlet weak var tableView: UITableView!
    var versionString : String?
    func changeViewController(_ menu: nextViewTyp) {
        self.changeViewController(menu.rawValue)
    }

    weak var delegate : ANSideMenuViewControllerDelegate?
    var menuModel : [String]?
    static var shared : ANSideMenuViewController?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgColor = ANStyleGuideManager.Colors.DarkModeGrayBackground()
        self.view.backgroundColor = bgColor
        ANSideMenuViewController.shared = self
        self.tableView.register(ServerSettingsDebugCell.self, forCellReuseIdentifier: "serverSettingDebugCell")
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = bgColor
    }
    
    @IBAction func deviceNameClick(_ sender: Any) {
        closeMenu()
    }
    
    @IBAction func closeMenuCliked(_ sender: Any) {
        self.closeMenu()
    }
    
    @objc func closeMenu() {
        self.closeLeft()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }


    func setActivityIndicatorView(toFrame: CGRect, toView: UIView){}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        generateModels()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        makeInteractable(interactable: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        makeInteractable(interactable: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeInteractable(interactable : Bool) {
        // self.tableView.isUserInteractionEnabled = interactable
    }
    
    func changeViewController(_ menu: String, lineIndex: Int? = nil) {
        print("cliked menu", menu)
        switch menu {
        case nextViewTyp.profile.rawValue:
            self.presentNotImplementedAlert()
            break
        case nextViewTyp.search.rawValue:
            self.presentNotImplementedAlert()
            break
        case nextViewTyp.about.rawValue:
            self.presentAboutFromMenu()
            break
        case nextViewTyp.feedback.rawValue:
            self.emailFeedback()
            break
        case nextViewTyp.signOut.rawValue:
            self.signOut()
            break
        default:
            self.presentNotImplementedAlert()
            break
        }
    }
    
    @objc func showPrimaryProvisioning(notification: Notification) {
        self.presentSignInFlowLineViewControllerFromMenu()
    }
    
    func generateModels() {
        menuModel = [String]()
        menuModel?.append(nextViewTyp.profile.rawValue)
        menuModel?.append(nextViewTyp.search.rawValue)
        menuModel?.append(nextViewTyp.about.rawValue)
        menuModel?.append(nextViewTyp.feedback.rawValue)
        menuModel?.append(nextViewTyp.signOut.rawValue)
        menuModel?.append(nextViewTyp.appversion.rawValue)

        self.tableView.reloadData()
    }
    
    // MARK: - Alerts
    @objc func presentNotImplementedAlert() {
        let alertController = UIAlertController.init(title: "Not Yet Implemented", message: "Come back soon!", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "Got it", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true) {
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
    override var shouldAutorotate: Bool {
        get {
            return true
        }
    }

    
    @objc func signOut() {
        if let isLoggedIn = UserDefaults.standard.value(forKey: "isLoggedIn") as? Bool , isLoggedIn == false {
            presentSignInFlowLineViewControllerFromMenu()
        }else{
            self.showPrimary()
        }

    }

    func showPrimary(){
        // let bundle = Bundle.init(for: ANStyleGuideManager.self)
        let vc = UIStoryboard.init(name: "Prompts", bundle: Bundle.main).instantiateViewController(withIdentifier: "ANPrimaryPromptViewController") as! ANPrimaryPromptViewController

        vc.allowTapToDismiss = true

        //              if let nav = self.navigationController {
        //                  nav.addChild(vc)
        //              } else {
        //                  self.addChild(vc)
        //              }

        let window =  AppDelegate.shared.window?.rootViewController // UIApplication.shared.keyWindow!
        window?.addChild(vc)

        /***********************************************************/
        /********************** build subview **********************/
        let stackView = UIStackView.init()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 20

        let subviewLabel = UILabel.init()
        subviewLabel.font = ANStyleGuideManager.Fonts.Body.Body4()
        subviewLabel.numberOfLines = 0

        let appName = SignOutConstants.signOutMessage.nsRanges(of: "\(Appname.appname)")
        var ranges : [NSRange]?
        ranges = appName

        let attribute = NSMutableAttributedString.init(string: SignOutConstants.signOutMessage)
        attribute.addAttributes([NSAttributedString.Key.font: ANStyleGuideManager.Fonts.Body.Body4(), NSAttributedString.Key.foregroundColor:ANStyleGuideManager.Colors.Title()], range: NSMakeRange(0, attribute.length))
        for range in ranges ?? []  {
            attribute.addAttributes([NSAttributedString.Key.font: ANStyleGuideManager.Fonts.Body.Body1(), NSAttributedString.Key.foregroundColor:ANStyleGuideManager.Colors.Title()], range: range)
        }

        subviewLabel.attributedText = attribute

        stackView.addArrangedSubview(subviewLabel)

        vc.setContentView(view: stackView)
        vc.setCancelButton(title: "Cancel") {
            vc._dismiss()
        }
        vc.setConfirmationButton(title: "Sign Out") {

            vc._dismiss()
            self.closeMenu()
            self.presentSignInFlowLineViewControllerFromMenu()
        }
        vc.set(title: "Sign out")
        vc.show()
    }

    
    func presentSignInFlowLineViewControllerFromMenu() {
        self.removePrompts()
        let onBoardingNav = ANIntroViewController.navigationWithController(type: PageType.LaunchScreen)
        if #available(iOS 13.0, *) {
            onBoardingNav.modalPresentationStyle = .fullScreen
            onBoardingNav.isModalInPresentation = true
        }
        if let container = (AppDelegate.shared.window?.rootViewController as? ContainerViewController) {
            container.present(onBoardingNav, animated: true, completion: {
                onBoardingNav.primaryProvisionDelegate = self
                self.closeMenu()
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
            })
            
            CFRunLoopWakeUp(CFRunLoopGetCurrent())
        }
    }
    
    func presentAboutFromMenu() {
        let vc = ANAboutViewController()
        let nav = ANRestrictedOrientationNavigationController.init(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
        CFRunLoopWakeUp(CFRunLoopGetCurrent())
    }
}

extension ANSideMenuViewController : ANSignInSignUpViewControllerDelegate {
    func didLogIn() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
    }

}

extension ANSideMenuViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if self.menuModel != nil {
            count = (menuModel?.count)!
        }
        return count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell?
        cell?.selectionStyle = .none

        func menuCells () -> UITableViewCell {
            if let model = self.menuModel, model[indexPath.row] == nextViewTyp.appversion.rawValue {
                let serverCell = tableView.dequeueReusableCell(withIdentifier: "serverSettingDebugCell", for: indexPath) as! ServerSettingsDebugCell
                serverCell.update(versionString: self.versionString)
                serverCell.contentView.backgroundColor = ANStyleGuideManager.Colors.DarkModeGrayBackground()
                return serverCell
            } else {
                let settingCell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingCell
                //                settingCell.backgroundColor = UIColor.red
                settingCell.settingName.text  = self.menuModel![indexPath.row]
                switch menuModel![indexPath.row] {
                case nextViewTyp.profile.rawValue:
                    settingCell.settingIcon.image = UIImage.init(named: "contacts")?.withRenderingMode(.alwaysTemplate)
                    settingCell.contentView.layer.addBorder(edge: .bottom, color: ANStyleGuideManager.Colors.CoolGray6, thickness: 1.0)
                    return settingCell
                case nextViewTyp.search.rawValue:
                    settingCell.settingIcon.image = UIImage.init(named: "SideMenu_Recents")?.withRenderingMode(.alwaysTemplate)
                    //  settingCell.contentView.layer.addBorder(edge: .bottom, color: ANStyleGuideManager.Colors.CoolGray6, thickness: 1.0)
                    return settingCell
                case nextViewTyp.about.rawValue:
                    settingCell.settingIcon.image = UIImage.init(named: "SideMenu_About")?.withRenderingMode(.alwaysTemplate)
                    // settingCell.contentView.layer.addBorder(edge: .bottom, color: ANStyleGuideManager.Colors.CoolGray6, thickness: 1.0)
                    return settingCell
                case nextViewTyp.feedback.rawValue:
                    settingCell.settingIcon.image = UIImage.init(named:"SideMenu_Settings")?.withRenderingMode(.alwaysTemplate)
                    //  settingCell.contentView.layer.addBorder(edge: .bottom, color: ANStyleGuideManager.Colors.CoolGray6, thickness: 1.0)
                    return settingCell
                case nextViewTyp.signOut.rawValue:
                    settingCell.settingIcon.image = UIImage.init(named: "circle")?.withRenderingMode(.alwaysTemplate)
                    settingCell.contentView.layer.addBorder(edge: .bottom, color: ANStyleGuideManager.Colors.CoolGray6, thickness: 1.0)
                    return settingCell
                default:
                    return cell!
                }
            }
        }
        return menuCells()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 56.0
        if let model = self.menuModel, model[indexPath.row] == nextViewTyp.appversion.rawValue {
            height = 80
        }else if let model = self.menuModel, model[indexPath.row] == nextViewTyp.profile.rawValue {
            height = 100
        }
        return CGFloat(height)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView.init()
        headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.tableView.width, height:0))
        headerView.backgroundColor = UIColor.red
        return headerView
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var sectionHeaderHight : CGFloat = 100.0
        sectionHeaderHight = CGFloat.leastNormalMagnitude
        return  sectionHeaderHight
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        func menuSelected(){
            if let model = self.menuModel {
                let selectedModelString = model[indexPath.row]
                switch selectedModelString {
                case nextViewTyp.profile.rawValue:
                    closeMenu()
                    changeViewController(nextViewTyp.profile)
                    break
                case nextViewTyp.search.rawValue:
                    closeMenu()
                    changeViewController(nextViewTyp.search)
                    break
                case nextViewTyp.about.rawValue:
                    closeMenu()
                    changeViewController(nextViewTyp.about)
                    break
                case nextViewTyp.feedback.rawValue:
                    self.emailFeedback()
                    closeMenu()
                    break
                case nextViewTyp.signOut.rawValue:
                    //closeMenu()
                    changeViewController(nextViewTyp.signOut)
                    break
                default:
                    break
                }
            }
        }
        menuSelected()
    }

    func emailFeedback() {
        AppDelegate.shared.tabViewController.emailFeedback()
    }
}






class SettingCell: UITableViewCell {
    @IBOutlet var settingIcon: UIImageView!
    @IBOutlet var settingName: UILabel!
    @IBOutlet weak var labelWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.settingName.adjustsFontSizeToFitWidth = true
        self.settingName.font =  ANStyleGuideManager.Fonts.Settings.Settings5()
        self.contentView.backgroundColor = ANStyleGuideManager.Colors.DarkModeGrayBackground()
        self.settingName.textColor = ANStyleGuideManager.Colors.Title()
        self.settingIcon.tintColor = ANStyleGuideManager.Colors.Icon()
    }
    
    //    override func prepareForReuse() {
    //        super.prepareForReuse()
    //        for v in self.contentView.subviews{
    //             v.layer.removeFromSuperlayer()
    //           // v.removeFromSuperview()
    //        }
    //    }
}




@IBDesignable class ShadowView: UIView
{
    @IBInspectable var gradientColor1: UIColor = UIColor.white {
        didSet{
            self.setGradient()
        }
    }
    
    @IBInspectable var gradientColor2: UIColor = UIColor.white {
        didSet{
            self.setGradient()
        }
    }
    
    @IBInspectable var gradientStartPoint: CGPoint = .zero {
        didSet{
            self.setGradient()
        }
    }
    
    @IBInspectable var gradientEndPoint: CGPoint = CGPoint(x: 0, y: 1) {
        didSet{
            self.setGradient()
        }
    }
    
    private func setGradient()
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [self.gradientColor1.cgColor, self.gradientColor2.cgColor]
        gradientLayer.startPoint = self.gradientStartPoint
        gradientLayer.endPoint = self.gradientEndPoint
        gradientLayer.frame = self.bounds
        if let topLayer = self.layer.sublayers?.first, topLayer is CAGradientLayer
        {
            topLayer.removeFromSuperlayer()
        }
        self.layer.addSublayer(gradientLayer)
    }
}
