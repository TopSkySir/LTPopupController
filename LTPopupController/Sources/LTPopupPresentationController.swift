//
//  LTPopupPresentationController.swift
//  LTPopupController
//
//  Created by TopSky on 2019/1/31.
//  Copyright © 2019 TopSky. All rights reserved.
//

import UIKit

open class LTPopupPresentationController: UIPresentationController {


    // MARK: - 蒙板属性

    /**
     蒙板颜色
     */
    open var dimmingColor: UIColor = UIColor.black

    /**
     蒙板初始透明度
     */
    open var initialDimmingAlpha: CGFloat = 0

    /**
     蒙板结束透明度
     */
    open var finalDimmingAlpha: CGFloat = 0.5



    // MARK: - 圆角阴影属性

    /**
     圆角
     */
    open var cornerRadius: CGFloat = 8

    /**
     阴影颜色
     */
    open var shadowColor: UIColor = UIColor.black

    /**
     阴影透明度
     */
    open var shadowOpacity: Float = 0.4

    /**
     阴影半径
     */
    open var shadowRadius: CGFloat = 10

    /**
     阴影偏移量
     */
    open var shadowOffset: CGSize = CGSize(width: 0, height: 6)


    // MARK: - 动画属性

    /**
     presented动画时间
     */
    open var presentedDuration: TimeInterval = 0.35

    /**
     dismiss动画时间
     */
    open var dismissDuration: TimeInterval = 0.35


    /**
     初始速度
     */
    open var springVelocity: CGFloat = 0.2



    // MARK: - UI组件

    fileprivate lazy var dimmingView: UIView = {
        let view = UIView()
        view.alpha = initialDimmingAlpha
        view.isOpaque = false
        view.backgroundColor = dimmingColor
        view.addGestureRecognizer(tapGesture)
        return view
    }()


    /**
     底部阴影
     */
    fileprivate lazy var customPresentedView: UIView = {
        let view = UIView()
        view.layer.shadowColor = shadowColor.cgColor
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowOffset = shadowOffset
        return view
    }()

    /**
     底部圆角
     */
    fileprivate lazy var customCornerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
        return view
    }()


    /**
     底部容器
     */
    fileprivate lazy var customContentView: UIView = {
        let view = UIView()
        return view
    }()



    // MARK: - 手势

    fileprivate lazy var tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissTap))
        return tap
    }()



    // MARK: - 其他

    /**
     类型
     */
    fileprivate var style: Style = .bottom

    /**
     点击蒙板是否Dismiss
     */
    open var isTapDismiss: Bool = true {
        didSet {
            tapGesture.isEnabled = isTapDismiss
        }
    }

    /**
     是否调用presentedViewController 生命周期Appear类函数
     */
    open var isAppear: Bool = false



    // MARK: - 初始化

    required public init(presentedViewController: UIViewController, presentingViewController: UIViewController?, style: Style) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        presentedViewController.modalPresentationStyle = .custom
        self.style = style
    }


    @objc fileprivate func dismissTap() {
        presentingViewController.dismiss(animated: true, completion: nil)
    }

}

// MARK: - 类型枚举

public extension LTPopupPresentationController {

    enum Style {
        case left
        case right
        case top
        case bottom
        case center

        /**
         获取自定义视图的布局
         */
        fileprivate func customFrames(_ presentedBounds: CGRect, _ cornerRadius: CGFloat) -> (cornerFrame: CGRect, contentFrame: CGRect) {
            var cornerFrame = CGRect.zero
            var contentFrame = CGRect.zero
            switch self {
            case .left:
                cornerFrame = presentedBounds.inset(by: UIEdgeInsets(top: 0, left: -cornerRadius, bottom: 0, right: 0))
                let cornerBounds = CGRect(origin: CGPoint.zero, size: cornerFrame.size)
                contentFrame = cornerBounds.inset(by: UIEdgeInsets(top: 0, left: cornerRadius, bottom: 0, right: 0))
            case .right:
                cornerFrame = presentedBounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -cornerRadius))
                let cornerBounds = CGRect(origin: CGPoint.zero, size: cornerFrame.size)
                contentFrame = cornerBounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: cornerRadius))
            case .top:
                cornerFrame = presentedBounds.inset(by: UIEdgeInsets(top: -cornerRadius, left: 0, bottom: 0, right: 0))
                let cornerBounds = CGRect(origin: CGPoint.zero, size: cornerFrame.size)
                contentFrame = cornerBounds.inset(by: UIEdgeInsets(top: cornerRadius, left: 0, bottom: 0, right: 0))
            case .bottom:
                cornerFrame = presentedBounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: -cornerRadius, right: 0))
                let cornerBounds = CGRect(origin: CGPoint.zero, size: cornerFrame.size)
                contentFrame = cornerBounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: cornerRadius, right: 0))
            case .center:
                cornerFrame = presentedBounds
                contentFrame = presentedBounds
            }
            return (cornerFrame, contentFrame)
        }

        /**
         获取presentedView Frame
         */
        fileprivate func presentedFrame(_ containerBounds: CGRect, _ containerSize: CGSize) -> CGRect {
            var presentedFrame = containerBounds
            switch self {
            case .left:
                presentedFrame.size.width = containerSize.width
            case .right:
                presentedFrame.size.width = containerSize.width
                presentedFrame.origin.x = containerBounds.maxX - containerSize.width
            case .top:
                presentedFrame.size.height = containerSize.height
            case .bottom:
                presentedFrame.size.height = containerSize.height
                presentedFrame.origin.y = containerBounds.maxY - containerSize.height
            case .center:
                presentedFrame.origin.x = (containerBounds.width - containerSize.width)/2
                presentedFrame.origin.y = (containerBounds.height - containerSize.height)/2
                presentedFrame.size = containerSize
            }
            return presentedFrame
        }

        /**
         获取初始化Frame
         */
        fileprivate func toInitalFrame(_ containerBounds: CGRect, _ finalFrame: CGRect) -> CGRect {
            var resultFrame = CGRect.zero
            switch self {
            case .left:
                resultFrame.origin = CGPoint(x: -finalFrame.width, y: containerBounds.minY)
                resultFrame.size = finalFrame.size
            case .right:
                resultFrame.origin = CGPoint(x: containerBounds.maxX, y: containerBounds.minY)
                resultFrame.size = finalFrame.size
            case .top:
                resultFrame.origin = CGPoint(x: containerBounds.minX, y: -finalFrame.height)
                resultFrame.size = finalFrame.size
            case .bottom:
                resultFrame.origin = CGPoint(x: containerBounds.minX, y: containerBounds.maxY)
                resultFrame.size = finalFrame.size
            case .center:
                break
            }
            return resultFrame
        }

        /**
         获取终止时候的frame
         */
        fileprivate func fromFinalFrame(_ frame: CGRect) -> CGRect {
            var resultFrame = CGRect.zero
            switch self {
            case .left:
                resultFrame = frame.offsetBy(dx: -frame.width, dy: 0)
            case .right:
                resultFrame = frame.offsetBy(dx: frame.width, dy: 0)
            case .top:
                resultFrame = frame.offsetBy(dx: 0, dy: -frame.height)
            case .bottom:
                resultFrame = frame.offsetBy(dx: 0, dy: frame.height)
            case .center:
                break
            }
            return resultFrame
        }
    }
}


// MARK: - 布局

fileprivate extension LTPopupPresentationController {

    func setCustomSubviews() {
        containerView?.addSubview(dimmingView)
        customPresentedView.addSubview(customCornerView)
        customCornerView.addSubview(customContentView)
        if let willPresentedView = super.presentedView {
            customContentView.addSubview(willPresentedView)
        }
    }

    func setCustomSubviewsFrame() {
        dimmingView.frame = containerView?.bounds ?? CGRect.zero
        customPresentedView.frame = frameOfPresentedViewInContainerView
        let tuple = style.customFrames(customPresentedView.bounds, cornerRadius)
        customCornerView.frame = tuple.cornerFrame
        customContentView.frame = tuple.contentFrame
        super.presentedView?.frame = customContentView.bounds
    }


    func cleanCustomSubviews() {
        dimmingView.removeFromSuperview()
        customPresentedView.removeFromSuperview()
        customCornerView.removeFromSuperview()
        customContentView.removeFromSuperview()
        for subview in customContentView.subviews {
            subview.removeFromSuperview()
        }
    }
}


// MARK: - 布局调整

extension LTPopupPresentationController {

    open override  var presentedView: UIView?{
        return customPresentedView
    }

    open override var frameOfPresentedViewInContainerView: CGRect {
        let containerBounds = containerView?.bounds ?? CGRect.zero
        let containerSize = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerBounds.size)
        return style.presentedFrame(containerBounds, containerSize)
    }

    open override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        let controller = container as? UIViewController
        guard controller == presentedViewController else {
            return
        }
        containerView?.setNeedsLayout()
    }

    open override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        let controller = container as? UIViewController
        guard controller == presentedViewController else {
            return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
        }
        return controller!.preferredContentSize
    }


    open override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        setCustomSubviewsFrame()
    }
}


// MARK: - 转场动画

extension LTPopupPresentationController {

    /**
     开启动画
     */
    fileprivate func presentedAnimation() {
        let coordinator = presentingViewController.transitionCoordinator
        dimmingView.alpha = initialDimmingAlpha
        coordinator?.animate(alongsideTransition: { (context) in
            self.dimmingView.alpha = self.finalDimmingAlpha
        }, completion: nil)
    }

    /**
     关闭动画
     */
    fileprivate func dismissAnimation() {
        let coordinator = presentingViewController.transitionCoordinator
        coordinator?.animate(alongsideTransition: { (context) in
            self.dimmingView.alpha = self.initialDimmingAlpha
        }, completion: nil)
    }

}

// MARK: - 转场周期

extension LTPopupPresentationController {

    open override func presentationTransitionWillBegin() {

        /**
         设置自定义视图
         */
        setCustomSubviews()

        /**
         设置动画
         */
        presentedAnimation()


        /**
         生命周期
         */
        if isAppear {
            presentingViewController.viewWillDisappear(true)
        }
    }

    open override func presentationTransitionDidEnd(_ completed: Bool) {
        guard completed else {
            /**
             清除视图
             */
            cleanCustomSubviews()

            /**
             生命周期
             */
            if isAppear {
                presentingViewController.viewWillAppear(true)
                presentingViewController.viewDidAppear(true)
            }
            return
        }

        /**
         生命周期
         */
        if isAppear {
            presentingViewController.viewDidDisappear(true)
        }
    }

    open override func dismissalTransitionWillBegin() {

        /**
         设置动画
         */
        dismissAnimation()

        /**
         生命周期
         */
        if isAppear {
            presentingViewController.viewWillAppear(true)
        }
    }

    open override func dismissalTransitionDidEnd(_ completed: Bool) {
        guard completed else {
            /**
             生命周期
             */
            if isAppear {
                presentingViewController.viewWillDisappear(true)
                presentingViewController.viewDidAppear(true)
            }
            return
        }

        /**
         清除视图
         */
        cleanCustomSubviews()

        /**
         生命周期
         */
        if isAppear {
            presentingViewController.viewDidAppear(true)
        }
    }

}


// MARK: - 转场动画代理

extension LTPopupPresentationController: UIViewControllerAnimatedTransitioning {

    /**
     转场时间
     */
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        guard let context = transitionContext else {
            return 0
        }
        let timeInterval = isPresenting(context) ? presentedDuration : dismissDuration
        return context.isAnimated ? timeInterval : 0
    }

    /**
     转场动画
     */
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        /**
         添加视图
         */
        if let toView = transitionContext.view(forKey: .to) {
            transitionContext.containerView.addSubview(toView)
        }

        /**
         判断专场类型
         */
        let isPresenting = self.isPresenting(transitionContext)

        /**
         转场时间
         */
        let duration = transitionDuration(using: transitionContext)

        /**
         转场动画
         */
        switch style {
        case .center:
            if isPresenting {
                centerPresentedAnimation(transitionContext, duration)
            } else {
                centerDismissAnimation(transitionContext, duration)
            }
        default:
            if isPresenting {
                otherPresentedAnimation(transitionContext, duration)
            } else {
                otherDismissedAnimation(transitionContext, duration)
            }
        }

    }

    /**
     Top,Left,Bottom,Right presented动画
     */
    fileprivate func otherPresentedAnimation(_ transitionContext: UIViewControllerContextTransitioning, _ duration: TimeInterval) {
        guard let toController = transitionContext.viewController(forKey: .to) else {
            return
        }
        let toView = transitionContext.view(forKey: .to)
        let containerBounds = containerView?.bounds ?? CGRect.zero
        let toFinalFrame = transitionContext.finalFrame(for: toController)
        toView?.frame = style.toInitalFrame(containerBounds, toFinalFrame)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: springVelocity, options: .curveEaseInOut, animations: {
            toView?.frame = toFinalFrame
        }) { (finished) in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }

    /**
     Top,Left,Bottom,Right dismiss动画
     */
    fileprivate func otherDismissedAnimation(_ transitionContext: UIViewControllerContextTransitioning, _ duration: TimeInterval) {
        let fromView = transitionContext.view(forKey: .from)
        let currentFrame = fromView?.frame ?? CGRect.zero
        let finalFrame = style.fromFinalFrame(currentFrame)
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            fromView?.frame = finalFrame
        }) { (finished) in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }

    /**
     Center类型 presented动画
     */
    fileprivate func centerPresentedAnimation(_ transitionContext: UIViewControllerContextTransitioning, _ duration: TimeInterval) {
        guard let toController = transitionContext.viewController(forKey: .to) else {
            return
        }
        let toView = transitionContext.view(forKey: .to)
        let toFinalFrame = transitionContext.finalFrame(for: toController)
        toView?.frame = toFinalFrame
        toView?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        toView?.alpha = 0
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: springVelocity, options: .curveEaseInOut, animations: {
            toView?.transform = CGAffineTransform(scaleX: 1, y: 1)
            toView?.alpha = 1
        }) { (finished) in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }

    /**
     Center类型 dismiss动画
     */
    fileprivate func centerDismissAnimation(_ transitionContext: UIViewControllerContextTransitioning, _ duration: TimeInterval) {
        let fromView = transitionContext.view(forKey: .from)
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            fromView?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            fromView?.alpha = 0
        }) { (finished) in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }


    /**
     是否是presented动画
     */
    fileprivate func isPresenting(_ transitionContext: UIViewControllerContextTransitioning) -> Bool {
        let fromController = transitionContext.viewController(forKey: .from)
        return fromController == presentingViewController
    }

}


// MARK: - 转场代理

extension LTPopupPresentationController: UIViewControllerTransitioningDelegate {

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }

}
