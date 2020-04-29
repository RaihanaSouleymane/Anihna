//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.


import UIKit

class ANIntroPageViewController: UIViewController {

  //  @IBOutlet weak var actionButton: UIButton!
    //@IBOutlet weak var subtitleTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageContainerView: ANRotatingView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var learnMoreButton: UIButton!
    @IBOutlet weak var imageContainerContainerView: UIView!
    @IBOutlet weak var spacingView: UIView!
    
    @IBOutlet weak var spacingViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var learnMoreButtonHeightConstraint: NSLayoutConstraint!
    // @IBOutlet weak var buttonContainerView: UIView!

    var page: ANmIntroPage?
    var pageActionHandler: ((ANmIntroPage) -> Void)?

    class func controllerForPage(page: ANmIntroPage) -> ANIntroPageViewController {
        let controller = UIStoryboard(name: "IntroPages", bundle: nil).instantiateViewController(withIdentifier: "PageViewController") as! ANIntroPageViewController
        controller.page = page
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.spacing = 5.0
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        titleLabel.text = page?.title
        titleLabel.numberOfLines = 0
        titleLabel.font = ANStyleGuideManager.Fonts.IntroPages.IntroPagesTitleBig()
//        subtitleTextView.attributedText = page?.attributedText()
//        subtitleTextView.font = ANStyleGuideManager.Fonts.Fields.Feed1MessagePreview()
//        subtitleTextView.textContainer.lineFragmentPadding = 0

        learnMore()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let titleLabelHeight = self.titleLabel.sizeThatFits(CGSize.init(width: titleLabel.frame.size.width, height: 100000)).height // self.titleLabel.intrinsicContentSize.height
        self.titleLabelHeightConstraint.constant = titleLabelHeight
        
        // calculate height for the image container
        let imageContainerHeight = self.view.frame.size.height - titleLabelHeight - learnMoreButtonHeightConstraint.constant - spacingViewConstraint.constant
        self.imageContainerViewHeightConstraint.constant = imageContainerHeight
    }

    func learnMore(){
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.alignment = .center

        let baseAttrs = [NSAttributedString.Key.font : ANStyleGuideManager.Fonts.CustomizeLine.SubTitle(), NSAttributedString.Key.paragraphStyle : paragraphStyle]


        let learnMore = NSMutableAttributedString.init(string: "Learn more", attributes: baseAttrs)
        learnMore.addAttribute(NSAttributedString.Key.underlineStyle,
                               value: NSUnderlineStyle.single.rawValue,
                               range:NSMakeRange(0, learnMore.length))
         learnMore.addAttribute(NSAttributedString.Key.foregroundColor, value: ANStyleGuideManager.Colors.Title(), range: NSMakeRange(0, learnMore.length))


        let finalAttrStr = NSMutableAttributedString.init()

        finalAttrStr.append(learnMore)

        self.learnMoreButton.setAttributedTitle(finalAttrStr, for: .normal)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let page = page, let image = UIImage(named: page.imageName) {
            imageContainerView.animateImageOn(withImage: image)
             //imageContainerView.backgroundColor = UIColor.red
        }
    }

    @IBAction func handleActionButton(_ sender: UIButton) {
        if let page = page {
            pageActionHandler?(page)
        }
    }

    @IBAction func learnMoreClicked(_ sender: Any) {
            ANUtilities.openBrowser(withUrl: "http://www.google.com")
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

