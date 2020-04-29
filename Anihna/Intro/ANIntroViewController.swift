//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.

import UIKit

class ANIntroViewController: UIViewController{//, NVActivityIndicatorViewable {

    //    @IBOutlet weak var secondTextView: UITextView!
    //    @IBOutlet weak var firstTextView: UITextView!
    //    @IBOutlet weak var textContainerView: UIView!


    @IBOutlet weak var spacingView: UIView!
    
    @IBOutlet weak var pageControlIndicatorView: UIView!

    @IBOutlet weak var confirmationButtonView: ANBlackConfirmationButtonView!     // ANConfirmationButtonView!
    @IBOutlet weak var subscribeButtonView: ANBlackConfirmationButtonView!
    @IBOutlet weak var asguestButtonView: ANBlackConfirmationButtonView!


    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dummySpaceProviderView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionContainerView: UIView!
    @IBOutlet weak var headerView: UIView!
    var startTime: Date?


    var introPages: ANIntroPages?
    weak var pageViewController: UIPageViewController!
    var viewControllers: [UIViewController] = []
    var topActionHandler: (() -> Void)?
    var pageActionHandler: ((ANmIntroPage) -> Void)?
    var isWhatsNewView: Bool = false
    var timer: Timer?

    @IBOutlet weak var termsConditionLbl: UILabel!

    @IBOutlet weak var termsAndConditionsContainer: UIView!
    @IBOutlet weak var termsConditionTxView: UITextView!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    
    var mdn : String?
    var loginToken : String?

    var pagesCount : Int = 0
    let selectedColor : UIColor = ANStyleGuideManager.Colors.Theme
    let notSelectedColor: UIColor = ANStyleGuideManager.Colors.CoolGray3

    //serverConfig

    var appName = "Anihna"

    class func navigationWithController(type: PageType) -> ANOnboardingNavigationController {
        let navigationController = UIStoryboard(name: "IntroPages", bundle: nil).instantiateInitialViewController() as! ANOnboardingNavigationController
        let controller = navigationController.topViewController as! ANIntroViewController
        controller.introPages = ANIntroPages.pages(type: type)


        if (UIDevice.current.userInterfaceIdiom == .pad)  {
            navigationController.modalTransitionStyle = .crossDissolve
            navigationController.modalPresentationStyle = .formSheet
        }

        return navigationController
    }

    class func navigationWithControllerForLaunchScreen() -> UINavigationController {
        return navigationWithController(type: .LaunchScreen)
    }


    override func viewDidLoad() {
        super.viewDidLoad()


        let bgColor = ANStyleGuideManager.Colors.Background()
        self.view.backgroundColor = bgColor
        self.spacingView.backgroundColor = bgColor
        self.buttonContainerView.backgroundColor = bgColor
        self.termsAndConditionsContainer.backgroundColor = ANStyleGuideManager.Colors.TermsAndConditionBackground()
        collectionContainerView.backgroundColor = bgColor
        if pageViewController == nil, let pageViewController = self.children.last as? UIPageViewController {
            
            if let introPages = introPages {
                pagesCount = introPages.pages.count
                for page in introPages.pages {
                    let controller = ANIntroPageViewController.controllerForPage(page: page)
                    controller.pageActionHandler = pageActionHandler
                    viewControllers.append(controller)

                }
                pageViewController.setViewControllers([viewControllers.first!], direction: .forward, animated: true) { (done: Bool) in
                }
            }
            //For Scrolling comment uncomment these lines and nextPage function :)
            pageViewController.dataSource = self
            pageViewController.delegate = self

            self.subscribeButtonView.button.setTitle("Get Started", for: .normal)
            self.subscribeButtonView.button.addTarget(self, action: #selector(getStartedButtonClicked(_:)), for: .touchUpInside)
            _ = self.subscribeButtonView.button.constrainFitInside(constrainInside: self.subscribeButtonView)
            self.subscribeButtonView.setColors(foreground: ANStyleGuideManager.Colors.InvertedTitle(), background: ANStyleGuideManager.Colors.InvertedBackground())

            self.asguestButtonView.button.setTitle("As Guest", for: .normal)
            self.asguestButtonView.setColors(foreground: ANStyleGuideManager.Colors.Title(), background: ANStyleGuideManager.Colors.Background())
            self.asguestButtonView.button.addTarget(self, action: #selector(asGuestButtonClicked(_:)), for: .touchUpInside)
            _ = self.asguestButtonView.button.constrainFitInside(constrainInside: self.asguestButtonView)


            let pageControlAppearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
            // pageindicator clear or hidden
            pageControlAppearance.pageIndicatorTintColor = notSelectedColor
            pageControlAppearance.currentPageIndicatorTintColor = selectedColor
        }

        //load page contents
        buttonContainerView.isHidden = !(introPages?.isNeedButton ?? false)
        let attributedString = NSMutableAttributedString(string: "By using this app you agree to our Terms & Conditions & Privacy Policy.")
        attributedString.addAttributes([NSAttributedString.Key.font:(ANStyleGuideManager.Fonts.Body.Body9()),NSAttributedString.Key.foregroundColor:ANStyleGuideManager.Colors.Title()], range: NSMakeRange(0, attributedString.length))

        let tcRange = attributedString.mutableString.range(of: "Terms & Conditions")
        if tcRange.location != NSNotFound {
            //attributedString.addAttribute(NSAttributedString.Key.link, value:  TermsConditionsConstants.urlConstants, range: tcRange)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range:tcRange)
        }
        let ppRange = attributedString.mutableString.range(of: "Privacy Policy.")
        if ppRange.location != NSNotFound {
            // attributedString.addAttribute(NSAttributedString.Key.link, value:  PrivacyPolicyConstants.urlConstants, range: ppRange)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range:ppRange)
        }

        //self.termsConditionTxView.delegate = self
        self.termsConditionTxView.backgroundColor = UIColor.clear
        termsConditionTxView.attributedText = attributedString
        termsConditionTxView.linkTextAttributes = [NSAttributedString.Key.foregroundColor: ANStyleGuideManager.Colors.Title()]
        termsConditionTxView.isEditable = false
        termsConditionTxView.isScrollEnabled = false


        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(textTapped))
        tapGesture.numberOfTapsRequired = 1
        termsConditionTxView.addGestureRecognizer(tapGesture)
    }


    @objc func textTapped(recognizer: UITapGestureRecognizer){

        let textView: UITextView = recognizer.view as! UITextView
        let point = recognizer.location(in: textView)
        if let detectedWord = getWordAtPosition(point){
//            print(detectedWord)
            if (TermsConditions.tc).contains(detectedWord){
                self.goToBrowser(forUrl: TermsConditionsConstants.urlConstants)

            }else if (TermsConditions.pp).contains(detectedWord){
                self.goToBrowser(forUrl: PrivacyPolicyConstants.urlConstants)

            }
        }
    }

    private final func getWordAtPosition(_ point: CGPoint) -> String?{
        if let textPosition = termsConditionTxView.closestPosition(to: point)
        {
            if let range = termsConditionTxView.tokenizer.rangeEnclosingPosition(textPosition, with: .word, inDirection: UITextDirection(rawValue: 1))
            {
                return termsConditionTxView.text(in: range)
            }
        }
        return nil

    }

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return false
        //return true
    }


    @objc func goToBrowser(forUrl : String) {
        ANUtilities.openBrowser(withUrl: forUrl)
    }

    // This will hide the Status Bar
    //    override var prefersStatusBarHidden: Bool {
    //        return true
    //    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // TODO: Check reachability

        startTracking()
        // startTimer()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        //Change back arrow color
        self.navigationController?.navigationBar.tintColor = ANStyleGuideManager.Colors.Title()
        // self.navigationController?.navigationBar.tintColor = .white


        //self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.isTranslucent = false

        // remove the text from the backbutton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let height = termsConditionTxView.intrinsicContentSize.height
        textViewHeightConstraint.constant = height
    }


    @objc func getStartedButtonClicked(_ sender: UIButton) {
        let controller = UIStoryboard(name: "SignInFlow", bundle: nil).instantiateViewController(withIdentifier: "ANSignInSignUpViewController") as! ANSignInSignUpViewController
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
        CFRunLoopWakeUp(CFRunLoopGetCurrent())
    }
    @objc func asGuestButtonClicked(_ sender: UIButton) {
    
        (self.navigationController as? ANOnboardingNavigationController)?.dismiss(animated: true) {
         AppDelegate.shared.tabViewController.set(visibleTab: .map)
       }

    }

    func viewControllerForIndex(index: Int) -> UIViewController? {
        if viewControllers.count > index {
            return viewControllers[index]
        }
        return nil
    }
}
extension ANIntroViewController : ANSignInSignUpViewControllerDelegate {
    func didLogIn() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
    }

}

// MARK: - UIPageViewController delegates
extension ANIntroViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let viewCount = viewControllers.count
        let index = (viewControllerIndex + 1) % viewCount
        return viewControllerForIndex(index: index)

    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let viewControllerIndex = viewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let viewCount = viewControllers.count
        let index = (viewControllerIndex + viewCount - 1) % viewCount
        return viewControllerForIndex(index: index)
    }


    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

    }
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        //If user interact, stop auto scroll.
        //stopTimer()

        if let controller = viewControllerForIndex(index: getCurrentIndex()) as? ANIntroPageViewController {
            controller.imageContainerView.animateImageOff {}
        }
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return getCurrentIndex()
    }

    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(ANIntroViewController.nextPage), userInfo: nil, repeats: true)
    }
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    @objc func nextPage() {
        let currentPage = getCurrentIndex()
        let index = (currentPage + 1) % viewControllers.count
        if let viewController = viewControllerForIndex(index: index) {
            pageViewController.setViewControllers([viewController], direction: .forward, animated: true){ (done: Bool) in

            }
        }
    }
}

extension ANIntroViewController: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        switch URL.path {
        case "pp":
            presentPolicyView()
        case "tac":
            presentTermsAndConditionView()
        default:
            break
        }
        return false
    }

    func presentTermsAndConditionView() {
        //        let termsAndConditionView = UIStoryboard(name: "ANessages", bundle: nil).instantiateViewController(withIdentifier: "ANTermsConditionsViewController")
        //        if let termsAndConditionView = termsAndConditionView as? ANTermsConditionsViewController {
        //            termsAndConditionView.configureForSettingsScreen = isWhatsNewView
        //            self.navigationController?.pushViewController(termsAndConditionView, animated: true)
        //        }
    }

    func presentPolicyView() {
        //        let url = NSURL(string: PRIVACY_POLICY_URL)
        //        let webViewController = UIStoryboard(name: "ANessages", bundle: nil).instantiateViewController(withIdentifier: "ANWebViewController")
        //        if let webViewController = webViewController as? ANWebViewController {
        //            webViewController.url = url as URL!;
        //            ANUtils.logCustEventName("ANSettings_PrivacyPolicyClicked", customAttributes:[:])
        //            kANMLocalyticsSettingsViewedPrivacyPolicy = true
        //            self.navigationController?.pushViewController(webViewController, animated: true)
        //        }
    }

    func startTracking() {
        startTime = Date()
        //        ANUtils.tagScreen("Settings - What's New")
        //        ANUtils.trigger(inAppMessage: "Settings - What's New")
    }


    func getCurrentIndex() -> Int {
        guard pageViewController != nil else{
            return 0
        }
        guard let firstViewController = pageViewController.viewControllers?.first,
            let firstViewControllerIndex = viewControllers.firstIndex(of: firstViewController) else {
                return 0
        }
        return firstViewControllerIndex
    }

    // MARK: - Orientation
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
}
