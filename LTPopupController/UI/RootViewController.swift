//
//  RootViewController.swift
//  TSNaviBarTransitionDemo
//
//  Created by TopSky on 2018/2/8.
//  Copyright © 2018年 TopSky. All rights reserved.
//

import UIKit

class RootViewController: BaseTableViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Popup测试"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("父viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("父viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("父viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("父viewDidDisappear")
    }

    override func add() {
        addAction(title: "底部测试") { [weak self] in
            let vc = SubViewController()
            let navi = UINavigationController(rootViewController: vc)
            let popupVC = LTPopupPresentationController(presentedViewController: navi, presentingViewController: self, style: .bottom)
            navi.preferredContentSize = CGSize(width: 300, height: 300)
            navi.transitioningDelegate = popupVC
            self?.present(navi, animated: true, completion: nil)
        }

        addAction(title: "顶部测试") { [weak self] in
            let vc = SubViewController()
            let navi = UINavigationController(rootViewController: vc)
            let popupVC = LTPopupPresentationController(presentedViewController: navi, presentingViewController: self, style: .top)
            navi.preferredContentSize = CGSize(width: 300, height: 300)
            navi.transitioningDelegate = popupVC
            self?.present(navi, animated: true, completion: nil)
        }

        addAction(title: "左侧测试") { [weak self] in
            let vc = SubViewController()
            let navi = UINavigationController(rootViewController: vc)
            let popupVC = LTPopupPresentationController(presentedViewController: navi, presentingViewController: self, style: .left)
            navi.preferredContentSize = CGSize(width: 300, height: 300)
            navi.transitioningDelegate = popupVC
            self?.present(navi, animated: true, completion: nil)
        }

        addAction(title: "右侧测试") { [weak self] in
            let vc = SubViewController()
            let navi = UINavigationController(rootViewController: vc)
            let popupVC = LTPopupPresentationController(presentedViewController: navi, presentingViewController: self, style: .right)
            navi.preferredContentSize = CGSize(width: 300, height: 300)
            navi.transitioningDelegate = popupVC
            self?.present(navi, animated: true, completion: nil)
        }

        addAction(title: "中心测试") { [weak self] in
            let vc = SubViewController()
            let navi = UINavigationController(rootViewController: vc)
            let popupVC = LTPopupPresentationController(presentedViewController: navi, presentingViewController: self, style: .center)
            navi.preferredContentSize = CGSize(width: 300, height: 300)
            navi.transitioningDelegate = popupVC
            self?.present(navi, animated: true, completion: nil)
        }

        addAction(title: "属性测试") { [weak self] in
            let vc = SubViewController()
            let navi = UINavigationController(rootViewController: vc)
            let popupVC = LTPopupPresentationController(presentedViewController: navi, presentingViewController: self, style: .center)
            popupVC.shadowRadius = 16
            popupVC.shadowColor = UIColor.red
            popupVC.shadowOffset = CGSize(width: -10, height: -10)
            popupVC.shadowOpacity = 1
            popupVC.cornerRadius = 16
            popupVC.presentedDuration = 0.7
            popupVC.dismissDuration = 0.7
            popupVC.springVelocity = 1
            popupVC.isAppear = true
            popupVC.isTapDismiss = false
            popupVC.dimmingColor = UIColor.green
            popupVC.initialDimmingAlpha = 0.2
            popupVC.finalDimmingAlpha = 1
            navi.preferredContentSize = CGSize(width: 300, height: 300)
            navi.transitioningDelegate = popupVC
            self?.present(navi, animated: true, completion: nil)
        }

        addAction(title: "无圆角无底色测试") { [weak self] in
            let vc = SubViewController()
            let navi = UINavigationController(rootViewController: vc)
            let popupVC = LTPopupPresentationController(presentedViewController: navi, presentingViewController: self, style: .bottom)
            popupVC.shadowColor = UIColor.clear
            popupVC.cornerRadius = 0
            popupVC.dimmingColor = UIColor.clear
            navi.preferredContentSize = CGSize(width: 300, height: 300)
            navi.transitioningDelegate = popupVC
            self?.present(navi, animated: true, completion: nil)
        }

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
