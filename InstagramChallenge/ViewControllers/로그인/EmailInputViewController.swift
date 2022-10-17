//
//  EmailInputViewController.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/25.
//

import UIKit
import XLPagerTabStrip

class EmailInputViewController: UIViewController, IndicatorInfoProvider {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "이메일")
    }
    
}
