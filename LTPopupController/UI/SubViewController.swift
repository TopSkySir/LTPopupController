//
//  SubViewController.swift
//  LTPopupController
//
//  Created by TopSky on 2019/1/31.
//  Copyright © 2019 TopSky. All rights reserved.
//

import UIKit

class SubViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "子视图"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("子viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("子viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("子viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("子viewDidDisappear")
    }

    deinit {
        print("子释放")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func add() {
        addAction(title: "改变Size") { [weak self] in
            let size = self?.navigationController?.preferredContentSize
            let resultSize = (size?.width == 300) ? CGSize(width: 200, height: 200) : CGSize(width: 300, height: 300)
            self?.navigationController?.preferredContentSize = resultSize
        }

        addAction(title: "返回") { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}

extension SubViewController {

    override var prefersStatusBarHidden: Bool {
        return false
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown, .landscapeLeft, .landscapeRight]
    }

    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
}
