//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.

import Foundation
import UIKit
  

@objc public protocol ANSlideMenuControllerDelegate {
    @objc optional func leftWillOpen()
    @objc optional func leftDidOpen()
    @objc optional func leftWillClose()
    @objc optional func leftDidClose()
    @objc optional func rightWillOpen()
    @objc optional func rightDidOpen()
    @objc optional func rightWillClose()
    @objc optional func rightDidClose()
}

public struct SlideMenuOptions {
    public static var leftViewWidth: CGFloat = 270.0
    public static var leftBezelWidth: CGFloat? = 100.0
    public static var contentViewScale: CGFloat = 1.0 //0.96
    public static var contentViewOpacity: CGFloat = 0.6
    public static var contentViewDrag: Bool = false
    public static var shadowOpacity: CGFloat = 0.0
    public static var shadowRadius: CGFloat = 0.0
    public static var shadowOffset: CGSize = CGSize(width: 0,height: 0)
    public static var panFromBezel: Bool = true
    public static var animationDuration: CGFloat = 0.4
    public static var animationOptions: UIView.AnimationOptions = []
    public static var hideStatusBar: Bool = false
    public static var pointOfNoReturnWidth: CGFloat = 135.0
    public static var simultaneousGestureRecognizers: Bool = true
    public static var opacityViewBackgroundColor: UIColor = UIColor.black
    public static var panGesturesEnabled: Bool = true
    public static var tapGesturesEnabled: Bool = true
}

open class ANSlideMenuController: UIViewController, UIGestureRecognizerDelegate {
    var leftViewWidthSize: CGFloat = 270.0
    var isSetUp = false

    public enum SlideAction {
        case open
        case close
    }

    public enum TrackAction {
        case leftTapOpen
        case leftTapClose
        case leftFlickOpen
        case leftFlickClose
    }


    struct PanInfo {
        var action: SlideAction
        var shouldBounce: Bool
        var velocity: CGFloat
    }

    open weak var delegate: ANSlideMenuControllerDelegate?

    open var opacityView = UIView()
    open var mainContainerView = UIView()
    open var leftContainerView = UIView()
    open var rightContainerView =  UIView()
    open var mainViewController: UIViewController?
    open var leftViewController: UIViewController?
    open var leftPanGesture: UIPanGestureRecognizer?
    open var leftTapGesture: UITapGestureRecognizer?
    open var rightViewController: UIViewController?
    open var rightPanGesture: UIPanGestureRecognizer?
    open var rightTapGesture: UITapGestureRecognizer?
    open var shouldSlideToShowMenu: Bool?

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public convenience init(mainViewController: UIViewController, leftMenuViewController: UIViewController) {
        self.init()

        self.mainViewController = mainViewController
        leftViewController = leftMenuViewController
        initView()
    }

    public convenience init(mainViewController: UIViewController, rightMenuViewController: UIViewController) {
        self.init()
        self.mainViewController = mainViewController
        rightViewController = rightMenuViewController
        initView()
    }

    public convenience init(mainViewController: UIViewController, leftMenuViewController: UIViewController, rightMenuViewController: UIViewController) {
        self.init()
        self.mainViewController = mainViewController
        leftViewController = leftMenuViewController
        rightViewController = rightMenuViewController
        initView()
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    open func initView() {
        self.leftViewWidthSize = view.bounds.width - 56 // Width of sideMenu View
        mainContainerView = UIView(frame: view.bounds)
        mainContainerView.backgroundColor = UIColor.clear
        mainContainerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.insertSubview(mainContainerView, at: 0)

        var opacityframe: CGRect = view.bounds
        let opacityOffset: CGFloat = 0
        opacityframe.origin.y = opacityframe.origin.y + opacityOffset
        opacityframe.size.height = opacityframe.size.height - opacityOffset
        opacityView = UIView(frame: opacityframe)
        opacityView.backgroundColor = SlideMenuOptions.opacityViewBackgroundColor
        opacityView.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight, UIView.AutoresizingMask.flexibleWidth]
        opacityView.layer.opacity = 0.0
        view.insertSubview(opacityView, at: 1)

        if leftViewController != nil {
            var leftFrame: CGRect = view.bounds
            leftFrame.size.width = leftViewWidthSize// SlideMenuOptions.leftViewWidth
            leftFrame.origin.x = leftMinOrigin()
            let leftOffset: CGFloat = 0
            leftFrame.origin.y = leftFrame.origin.y + leftOffset
            leftFrame.size.height = leftFrame.size.height - leftOffset
            leftContainerView = UIView(frame: leftFrame)
            leftContainerView.backgroundColor = UIColor.clear
            leftContainerView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
            view.insertSubview(leftContainerView, at: 2)
            addLeftGestures()
        }
    }

    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        mainContainerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        leftContainerView.isHidden = true
        //rightContainerView.isHidden = true

        coordinator.animate(alongsideTransition: nil, completion: { (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.closeLeftNonAnimation()
            self.leftContainerView.isHidden = false
            if self.leftPanGesture != nil {
                self.removeLeftGestures()
                self.addLeftGestures()
            }
        })
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge()
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    open override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if let mainController = self.mainViewController {
            return mainController.supportedInterfaceOrientations
        }
        return UIInterfaceOrientationMask.allButUpsideDown
    }

    open override var shouldAutorotate : Bool {
        return mainViewController?.shouldAutorotate ?? false
    }

    open override func viewWillLayoutSubviews() {
        if isSetUp == false {
            setUpViewController(mainContainerView, targetViewController: mainViewController)
            setUpViewController(leftContainerView, targetViewController: leftViewController)
            isSetUp = true
        }
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.mainViewController?.preferredStatusBarStyle ?? .lightContent
    }

    @objc  override open func openLeft() {
        guard let _ = leftViewController else {
            return
        }
    
        // if self.shouldSlideToShowMenu! {
        self.delegate?.leftWillOpen?()
        setOpenWindowLevel()
        leftViewController?.beginAppearanceTransition(isLeftHidden(), animated: true)
        openLeftWithVelocity(0.0)

        track(.leftTapOpen)

        //statusBar on Open

        //UIApplication.shared.statusBarView?.isHidden = true
//       UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear


        //  }

    }
    //    override open var prefersStatusBarHidden: Bool {
    //        return true
    //    }
    override public func closeLeft() {
        guard let _ = leftViewController else {
            return
        }

        self.delegate?.leftWillClose?()

        leftViewController?.beginAppearanceTransition(isLeftHidden(), animated: true)
        closeLeftWithVelocity(0.0)
        setCloseWindowLevel()



        //statusBar on Close

        //UIApplication.shared.statusBarView?.isHidden = false
        // UIApplication.shared.statusBarView?.backgroundColor = UIColor.white
    }

    open func addLeftGestures() {

        if leftViewController != nil {
            if SlideMenuOptions.panGesturesEnabled {
                if leftPanGesture == nil {
                    leftPanGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleLeftPanGesture(_:)))
                    leftPanGesture!.delegate = self
                    view.addGestureRecognizer(leftPanGesture!)
                }
            }

            if SlideMenuOptions.tapGesturesEnabled {
                if leftTapGesture == nil {
                    leftTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.toggleLeft))
                    leftTapGesture!.delegate = self
                    view.addGestureRecognizer(leftTapGesture!)
                }
            }
        }
    }


    open func removeLeftGestures() {

        if leftPanGesture != nil {
            view.removeGestureRecognizer(leftPanGesture!)
            leftPanGesture = nil
        }

        if leftTapGesture != nil {
            view.removeGestureRecognizer(leftTapGesture!)
            leftTapGesture = nil
        }
    }


    open func isTagetViewController() -> Bool {
        // Function to determine the target ViewController
        return true
    }

    open func track(_ trackAction: TrackAction) {
        // function is for tracking

    }

    struct LeftPanState {
        static var frameAtStartOfPan: CGRect = CGRect.zero
        static var startPointOfPan: CGPoint = CGPoint.zero
        static var wasOpenAtStartOfPan: Bool = false
        static var wasHiddenAtStartOfPan: Bool = false
        static var lastState : UIGestureRecognizer.State = .ended
    }

    @objc func handleLeftPanGesture(_ panGesture: UIPanGestureRecognizer) {

        if !isTagetViewController() {
            return
        }
        //if self.shouldSlideToShowMenu! {

        switch panGesture.state {
        case UIGestureRecognizer.State.began:
            if LeftPanState.lastState != .ended &&  LeftPanState.lastState != .cancelled &&  LeftPanState.lastState != .failed {
                return
            }

            if isLeftHidden() {

                self.delegate?.leftWillOpen?()
            } else {
                self.delegate?.leftWillClose?()
            }

            LeftPanState.frameAtStartOfPan = leftContainerView.frame
            LeftPanState.startPointOfPan = panGesture.location(in: view)
            LeftPanState.wasOpenAtStartOfPan = isLeftOpen()
            LeftPanState.wasHiddenAtStartOfPan = isLeftHidden()

            leftViewController?.beginAppearanceTransition(LeftPanState.wasHiddenAtStartOfPan, animated: true)
            addShadowToView(leftContainerView)
            setOpenWindowLevel()
        case UIGestureRecognizer.State.changed:
            if LeftPanState.lastState != .began && LeftPanState.lastState != .changed {
                return
            }

            let translation: CGPoint = panGesture.translation(in: panGesture.view!)
            leftContainerView.frame = applyLeftTranslation(translation, toFrame: LeftPanState.frameAtStartOfPan)
            applyLeftOpacity()
            applyLeftContentViewScale()
        case UIGestureRecognizer.State.ended, UIGestureRecognizer.State.cancelled:
            if LeftPanState.lastState != .changed {
                setCloseWindowLevel()
                return
            }

            let velocity:CGPoint = panGesture.velocity(in: panGesture.view)
            let panInfo: PanInfo = panLeftResultInfoForVelocity(velocity)

            if panInfo.action == .open {
                if !LeftPanState.wasHiddenAtStartOfPan {
                    leftViewController?.beginAppearanceTransition(true, animated: true)
                }
                openLeftWithVelocity(panInfo.velocity)

                track(.leftFlickOpen)
            } else {
                if LeftPanState.wasHiddenAtStartOfPan {
                    leftViewController?.beginAppearanceTransition(false, animated: true)
                }
                closeLeftWithVelocity(panInfo.velocity)
                setCloseWindowLevel()

                track(.leftFlickClose)

            }
        case UIGestureRecognizer.State.failed, UIGestureRecognizer.State.possible:
            break
        @unknown default:
            break
        }
        //    }


        LeftPanState.lastState = panGesture.state
    }

    struct RightPanState {
        static var frameAtStartOfPan: CGRect = CGRect.zero
        static var startPointOfPan: CGPoint = CGPoint.zero
        static var wasOpenAtStartOfPan: Bool = false
        static var wasHiddenAtStartOfPan: Bool = false
        static var lastState : UIGestureRecognizer.State = .ended
    }

    func handleRightPanGesture(_ panGesture: UIPanGestureRecognizer) {

        if !isTagetViewController() {
            return
        }

        if isLeftOpen() {
            return
        }

        switch panGesture.state {
        case UIGestureRecognizer.State.began:
            if RightPanState.lastState != .ended &&  RightPanState.lastState != .cancelled &&  RightPanState.lastState != .failed {
                return
            }
            setOpenWindowLevel()
        case UIGestureRecognizer.State.changed:
            if RightPanState.lastState != .began && RightPanState.lastState != .changed {
                return
            }
        case UIGestureRecognizer.State.ended, UIGestureRecognizer.State.cancelled:
            if RightPanState.lastState != .changed {
                setCloseWindowLevel()
                return
            }
        case UIGestureRecognizer.State.failed, UIGestureRecognizer.State.possible:
            break
        }

        RightPanState.lastState = panGesture.state
    }

    open func openLeftWithVelocity(_ velocity: CGFloat) {
        let xOrigin: CGFloat = leftContainerView.frame.origin.x
        let finalXOrigin: CGFloat = 0.0

        var frame = leftContainerView.frame
        frame.origin.x = finalXOrigin

        var duration: TimeInterval = Double(SlideMenuOptions.animationDuration)
        if velocity != 0.0 {
            duration = Double(abs(xOrigin - finalXOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }

        addShadowToView(leftContainerView)

        UIView.animate(withDuration: duration, delay: 0.0, options: SlideMenuOptions.animationOptions, animations: { [weak self]() -> Void in
            if let strongSelf = self {
                strongSelf.leftContainerView.frame = frame
                strongSelf.opacityView.layer.opacity = Float(SlideMenuOptions.contentViewOpacity)

                SlideMenuOptions.contentViewDrag == true ? (strongSelf.mainContainerView.transform = CGAffineTransform(translationX: (self?.leftViewWidthSize)!, y: 0)) : (strongSelf.mainContainerView.transform = CGAffineTransform(scaleX: SlideMenuOptions.contentViewScale, y: SlideMenuOptions.contentViewScale))

            }
        }) { [weak self](Bool) -> Void in
            if let strongSelf = self {
                strongSelf.disableContentInteraction()
                strongSelf.leftViewController?.endAppearanceTransition()
                strongSelf.delegate?.leftDidOpen?()
            }
        }
    }

    open func closeLeftWithVelocity(_ velocity: CGFloat) {

        let xOrigin: CGFloat = leftContainerView.frame.origin.x
        let finalXOrigin: CGFloat = leftMinOrigin()

        var frame: CGRect = leftContainerView.frame
        frame.origin.x = finalXOrigin

        var duration: TimeInterval = Double(SlideMenuOptions.animationDuration)
        if velocity != 0.0 {
            duration = Double(abs(xOrigin - finalXOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }

        UIView.animate(withDuration: duration, delay: 0.0, options: SlideMenuOptions.animationOptions, animations: { [weak self]() -> Void in
            if let strongSelf = self {
                strongSelf.leftContainerView.frame = frame
                strongSelf.opacityView.layer.opacity = 0.0
                strongSelf.mainContainerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }) { [weak self](Bool) -> Void in
            if let strongSelf = self {
                strongSelf.removeShadow(strongSelf.leftContainerView)
                strongSelf.enableContentInteraction()
                strongSelf.leftViewController?.endAppearanceTransition()
                strongSelf.delegate?.leftDidClose?()
            }
        }
    }
    @objc open override func toggleLeft() {

        func openSideMenu() {
            if isLeftOpen() {
                closeLeft()
                setCloseWindowLevel()
                track(.leftTapClose)
            } else {
                openLeft()
            }
        }
         openSideMenu()
        
//Always open side menu even when in active call

//        if #available(iOS 13.0, *) {
//            if ANCallManager.shared.activeCallVC == nil || ANCallManager.shared.activeCallVC!.callConfigIds.isEmpty {
//                openSideMenu()
//            }
//        }else{
//            openSideMenu()
//        }
    }

    open func isLeftOpen() -> Bool {
        return leftViewController != nil && leftContainerView.frame.origin.x == 0.0
    }

    open func isLeftHidden() -> Bool {
        return leftContainerView.frame.origin.x <= leftMinOrigin()
    }


    open func changeMainViewController(_ mainViewController: UIViewController,  close: Bool) {

        removeViewController(self.mainViewController)
        self.mainViewController = mainViewController

        setUpViewController(mainContainerView, targetViewController: mainViewController)
        //        if (mainViewController.childViewControllers[0]).isKind(of: MainViewController.self)  {
        //            let main =
        //
        //        }
        if ((mainViewController as? UINavigationController)?.topViewController) != nil {
            // topViewController.setNavigationBarItem()
        }

        if close {
            closeLeft()
        }
    }

    open func changeLeftViewWidth(_ width: CGFloat) {

        SlideMenuOptions.leftViewWidth = width
        var leftFrame: CGRect = view.bounds
        leftFrame.size.width = width
        leftFrame.origin.x = leftMinOrigin()
        let leftOffset: CGFloat = 0
        leftFrame.origin.y = leftFrame.origin.y + leftOffset
        leftFrame.size.height = leftFrame.size.height - leftOffset
        leftContainerView.frame = leftFrame
    }

    open func changeLeftViewController(_ leftViewController: UIViewController, closeLeft:Bool) {

        removeViewController(self.leftViewController)
        self.leftViewController = leftViewController
        setUpViewController(leftContainerView, targetViewController: leftViewController)
        if closeLeft {
            self.closeLeft()
        }
    }


    fileprivate func leftMinOrigin() -> CGFloat {
        return  -leftViewWidthSize//SlideMenuOptions.leftViewWidth
    }

    fileprivate func rightMinOrigin() -> CGFloat {
        return view.bounds.width
    }


    fileprivate func panLeftResultInfoForVelocity(_ velocity: CGPoint) -> PanInfo {

        let thresholdVelocity: CGFloat = 1000.0
        let pointOfNoReturn: CGFloat = CGFloat(floor(leftMinOrigin())) + SlideMenuOptions.pointOfNoReturnWidth
        let leftOrigin: CGFloat = leftContainerView.frame.origin.x

        var panInfo: PanInfo = PanInfo(action: .close, shouldBounce: false, velocity: 0.0)

        panInfo.action = leftOrigin <= pointOfNoReturn ? .close : .open

        if velocity.x >= thresholdVelocity {
            panInfo.action = .open
            panInfo.velocity = velocity.x
        } else if velocity.x <= (-1.0 * thresholdVelocity) {
            panInfo.action = .close
            panInfo.velocity = velocity.x
        }

        return panInfo
    }

    fileprivate func applyLeftTranslation(_ translation: CGPoint, toFrame:CGRect) -> CGRect {

        var newOrigin: CGFloat = toFrame.origin.x
        newOrigin += translation.x

        let minOrigin: CGFloat = leftMinOrigin()
        let maxOrigin: CGFloat = 0.0
        var newFrame: CGRect = toFrame

        if newOrigin < minOrigin {
            newOrigin = minOrigin
        } else if newOrigin > maxOrigin {
            newOrigin = maxOrigin
        }

        newFrame.origin.x = newOrigin
        return newFrame
    }


    fileprivate func getOpenedLeftRatio() -> CGFloat {

        let width: CGFloat = leftContainerView.frame.size.width
        let currentPosition: CGFloat = leftContainerView.frame.origin.x - leftMinOrigin()
        return currentPosition / width
    }
    fileprivate func applyLeftOpacity() {

        let openedLeftRatio: CGFloat = getOpenedLeftRatio()
        let opacity: CGFloat = SlideMenuOptions.contentViewOpacity * openedLeftRatio
        opacityView.layer.opacity = Float(opacity)
    }

    fileprivate func applyLeftContentViewScale() {
        return
    }

    fileprivate func addShadowToView(_ targetContainerView: UIView) {
        targetContainerView.layer.masksToBounds = false
        targetContainerView.layer.shadowOffset = SlideMenuOptions.shadowOffset
        targetContainerView.layer.shadowOpacity = Float(SlideMenuOptions.shadowOpacity)
        targetContainerView.layer.shadowRadius = SlideMenuOptions.shadowRadius
        targetContainerView.layer.shadowPath = UIBezierPath(rect: targetContainerView.bounds).cgPath
    }

    fileprivate func removeShadow(_ targetContainerView: UIView) {
        targetContainerView.layer.masksToBounds = true
        mainContainerView.layer.opacity = 1.0
    }

    fileprivate func removeContentOpacity() {
        opacityView.layer.opacity = 0.0
    }


    fileprivate func addContentOpacity() {
        opacityView.layer.opacity = Float(SlideMenuOptions.contentViewOpacity)
    }

    fileprivate func disableContentInteraction() {
        mainContainerView.isUserInteractionEnabled = false
    }

    fileprivate func enableContentInteraction() {
        mainContainerView.isUserInteractionEnabled = true
    }

    fileprivate func setOpenWindowLevel() {
        if SlideMenuOptions.hideStatusBar {
            DispatchQueue.main.async(execute: {
                if let window = UIApplication.shared.keyWindow {
                    window.windowLevel = UIWindow.Level.normal//UIWindowLevelStatusBar + 1
                }
            })
        }
    }

    fileprivate func setCloseWindowLevel() {
        if SlideMenuOptions.hideStatusBar {
            DispatchQueue.main.async(execute: {
                if let window = UIApplication.shared.keyWindow {
                    window.windowLevel = UIWindow.Level.normal
                }
            })
        }
    }

    fileprivate func setUpViewController(_ targetView: UIView, targetViewController: UIViewController?) {
        if let viewController = targetViewController {
            viewController.view.frame = targetView.bounds

            if (!children.contains(viewController)) {
                addChild(viewController)
                targetView.addSubview(viewController.view)
                viewController.didMove(toParent: self)
            }
        }
    }


    fileprivate func removeViewController(_ viewController: UIViewController?) {
        if let _viewController = viewController {
            _viewController.view.layer.removeAllAnimations()
            _viewController.willMove(toParent: nil)
            _viewController.view.removeFromSuperview()
            _viewController.removeFromParent()
        }
    }

    open func closeLeftNonAnimation(){
        setCloseWindowLevel()
        let finalXOrigin: CGFloat = leftMinOrigin()
        var frame: CGRect = leftContainerView.frame
        frame.origin.x = finalXOrigin
        leftContainerView.frame = frame
        opacityView.layer.opacity = 0.0
        mainContainerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        removeShadow(leftContainerView)
        enableContentInteraction()
    }


    // MARK: UIGestureRecognizerDelegate
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let point: CGPoint = touch.location(in: view)

        if gestureRecognizer == leftPanGesture {
            return slideLeftForGestureRecognizer(gestureRecognizer, point: point)
        } else if gestureRecognizer == leftTapGesture {
            return isLeftOpen() && !isPointContainedWithinLeftRect(point)
        }
        return true
    }


    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
        //return SlideMenuOptions.simultaneousGestureRecognizers
    }

    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {

        let velocity : CGPoint = (leftPanGesture?.velocity(in: self.view))!
        if gestureRecognizer.isKind(of: UIPanGestureRecognizer.self){
            return abs(velocity.x) > abs(velocity.y)
        }
        else {
            toggleLeft()
            return false
        }
    }

    fileprivate func slideLeftForGestureRecognizer( _ gesture: UIGestureRecognizer, point:CGPoint) -> Bool{
        return isLeftOpen() || SlideMenuOptions.panFromBezel && isLeftPointContainedWithinBezelRect(point)
    }

    fileprivate func isLeftPointContainedWithinBezelRect(_ point: CGPoint) -> Bool{
        if let bezelWidth = SlideMenuOptions.leftBezelWidth {
            var leftBezelRect: CGRect = CGRect.zero
            let tuple = view.bounds.divided(atDistance: bezelWidth, from: CGRectEdge.minXEdge)
            leftBezelRect = tuple.slice
            return leftBezelRect.contains(point)
        } else {
            return true
        }
    }

    fileprivate func isPointContainedWithinLeftRect(_ point: CGPoint) -> Bool {
        return leftContainerView.frame.contains(point)
    }
}


extension UIViewController {

    func addCloseButton(target: Selector,position: Int){
        let closeBBI = ANStandardViewFactory.closeBarButtonItem()
        if let closeButton = closeBBI.customView as? UIButton {
            closeButton.addTarget(self, action: target, for: .touchUpInside)

            switch position {
            case 0:
                self.navigationItem.setRightBarButton(closeBBI, animated: true)
            case 1:
                self.navigationItem.setLeftBarButton(closeBBI, animated: true)
            default:
                break
            }
        }
    }

    func addLeftMenuIcon(){
        let button = UIButton.init(type: .custom)
        let image = UIImage.init(named: "Icon - Sidebar - Black")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = ANStyleGuideManager.Colors.Icon()
        button.addTarget(self, action: #selector(ANSlideMenuController.toggleLeft), for: .touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 38, height: 38)
        button.contentMode = .scaleAspectFill
        let menuBBI = UIBarButtonItem.init(customView: button)
        navigationItem.leftBarButtonItem = menuBBI

        let widthConstraint = button.widthAnchor.constraint(equalToConstant: 38)
        let heightConstraint = button.heightAnchor.constraint(equalToConstant: 38)
        heightConstraint.isActive = true
        widthConstraint.isActive = true

    }

    public func slideMenuController() -> ANSlideMenuController? {
        var viewController: UIViewController? = self
        while viewController != nil {
            if viewController is ANSlideMenuController {
                return viewController as? ANSlideMenuController
            }
            viewController = viewController?.parent
        }
        return nil
    }

    public func addLeftBarButton() {
        let button = UIButton.init(type: .custom)
        let image = UIImage.init(named: "menu")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = ANStyleGuideManager.Colors.Icon()
        button.addTarget(self, action: #selector(self.toggleLeft), for: .touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 28, height: 28)
        button.contentMode = .scaleAspectFill
        let menuBBI = UIBarButtonItem.init(customView: button)
        navigationItem.leftBarButtonItem = menuBBI
    }

    @objc public func toggleLeft() {
        slideMenuController()?.toggleLeft()
    }

    @objc public func toggleRight() {
        slideMenuController()?.toggleRight()
    }

    @objc public func openLeft() {
        slideMenuController()?.openLeft()
    }

    @objc  public func closeLeft() {
        slideMenuController()?.closeLeft()
    }
}

extension UIViewController {

    func setNavigationBarItem() {
        self.addLeftBarButton()
        //self.addRightBarButton()
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.addLeftGestures()
    }

    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
    }
    func stopShowingMenu () {
        self.slideMenuController()?.shouldSlideToShowMenu = false
    }
    func showingMenu () {
        self.slideMenuController()?.shouldSlideToShowMenu = true
    }

    func removeGesturesLeft(){
        self.slideMenuController()?.removeLeftGestures()

    }
    func addGesturesLeft(){
        self.slideMenuController()?.addLeftGestures()
    }


    func showAlert1(_ title: String){
        show(title, message: "")
    }

    func show(_ title: String, message: String){
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default) { [weak self] (action : UIAlertAction) in
            self?.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


extension UIViewController {

    func setBackButton(whiteArrow: Bool = false){

        var image : UIImage!

        image = UIImage.init(named: "Icon - Back - White")?.withRenderingMode(.alwaysTemplate)

        let button = UIButton.init()
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(UIViewController.navBackButtonTapped), for: .touchUpInside)
        button.setImage(image, for: .normal)
        button.tintColor = ANStyleGuideManager.Colors.Icon()
        button.frame = CGRect.init(x: 0, y: 0, width: 38, height: 38)

        let bbi = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = bbi
        self.navigationController?.navigationBar.backItem?.title = ""
    }

    func setDismissButton() -> UIBarButtonItem {

        let image = UIImage.init(named: "Icon - Close - Black")?.withRenderingMode(.alwaysTemplate)
        let button = UIButton.init()
        button.adjustsImageWhenHighlighted = false
        button.tintColor = ANStyleGuideManager.Colors.Icon()
        button.setImage(image, for: .normal)

        if #available(iOS 10.0, *) {
            button.frame = CGRect.init(x: 0, y: 0, width: 38, height: 38)
        } else {
            // Fallback on earlier versions
            let widthConstraint = button.widthAnchor.constraint(equalToConstant: 38)
            let heightConstraint = button.heightAnchor.constraint(equalToConstant: 38)
            heightConstraint.isActive = true
            widthConstraint.isActive = true
        }

        let bbi = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = bbi

        return bbi
    }

    @objc func navBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func removePrompts(){
        for v in self.children {
            if ((v as? ANPrimaryPromptViewController) != nil) {
                let VC = v as! ANPrimaryPromptViewController
                VC._dismiss()
            }
            if ((v as? ANSecondaryPromptViewController) != nil) {
                let VC = v as! ANSecondaryPromptViewController
                VC._dismiss()
            }
        }
    }

    @objc func removePromptsFromWindow(){

        if let window =  AppDelegate.shared.window?.rootViewController {
            for v in window.children {
                if ((v as? ANPrimaryPromptViewController) != nil) {
                    let VC = v as! ANPrimaryPromptViewController
                    VC._dismiss()
                }
                if ((v as? ANSecondaryPromptViewController) != nil) {
                    let VC = v as! ANSecondaryPromptViewController
                    VC._dismiss()
                }
            }
        }
    }
}

class ContainerViewController: ANSlideMenuController {
    var isFirstTime = false
    override func awakeFromNib() {
        let isLoggedIn = UserDefaults.standard.value(forKey: "isLoggedIn") as? Bool ?? false
        if isLoggedIn  == false {
            isFirstTime = true

            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "ANSideMenuViewController") {
                self.leftViewController = controller
            }
        }else{
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "ANSideMenuViewController") {
                self.leftViewController = controller
            }

            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "ANMainTabBarViewController") {
                self.mainViewController = controller
            }
        }
        
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "ANMainTabBarViewController") {
            self.mainViewController = controller
        }
        
        super.awakeFromNib()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ANStyleGuideManager.Colors.Background()
//        NotificationCenter.default.addObserver(self, selector: #selector(statusBarWillChange(notification:)), name: Notification.Name.init(rawValue: "UIApplicationWillChangeStatusBarFrameNotification"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(statusBarDidChange(notification:)), name: Notification.Name.init(rawValue: "UIApplicationDidChangeStatusBarFrameNotification"), object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if isFirstTime == true {
            presentInitialViewController()
            isFirstTime = false
        }
    }

    func presentInitialViewController() {
        if isFirstTime {
            let onBoardingNav = ANIntroViewController.navigationWithController(type: PageType.LaunchScreen)
            if #available(iOS 13.0, *) {
                onBoardingNav.isModalInPresentation = true
                onBoardingNav.modalPresentationStyle = .fullScreen
            }
            if let container = (AppDelegate.shared.window?.rootViewController as? ContainerViewController) {
                container.present(onBoardingNav, animated: true, completion: {
                    onBoardingNav.primaryProvisionDelegate = AppDelegate.shared.sideM
                    //                    if let controller = self.storyboard?.instantiateViewController(withIdentifier: "ANSideMenuViewController")  {
                    //                       container.leftViewController = controller
                    //
                    //                    }
                    //
                })
            }
        }
    }

    @objc func statusBarWillChange(notification: Notification) {
        if let newFrame = notification.userInfo?["UIApplicationStatusBarFrameUserInfoKey"] as? CGRect {
            let old = self.view.frame
            self.view.frame = CGRect.init(x: old.origin.x, y: old.origin.y, width: old.width, height: old.height - newFrame.height)
        }
    }
    
    @objc func statusBarDidChange(notification: Notification) {
        if let _ = notification.userInfo?["UIApplicationStatusBarFrameUserInfoKey"] as? CGRect {
            
        }
    }
}
