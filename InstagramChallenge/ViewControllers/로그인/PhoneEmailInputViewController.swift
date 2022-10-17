//
//  PhoneEmailInputViewController.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/25.
//

import UIKit
import XLPagerTabStrip

class PhoneEmailInputViewController: ButtonBarPagerTabStripViewController {
    
    @IBAction func tapCloseButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapLoginButton(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "InitialViewController") else { return }
        self.changeRootViewController(vc)
    }
    
    
    override func viewDidLoad() {
        configureButtonBar()
        super.viewDidLoad()
    }
    
    // MARK: 바에 자식 등록
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child1 = PhoneInputViewController()
        let child2 = EmailInputViewController()
        
        return [child1,  child2]
    }
    
    // MARK: 바 세팅
    func configureButtonBar() {
        //Changing item text color on swipe
        changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .gray
            newCell?.label.textColor = .black
        }
        
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarHeight = 3.0
        
        settings.style.buttonBarItemFont = UIFont(name: "Helvetica-Bold", size: 17.0)!
        settings.style.buttonBarItemTitleColor = .gray
        settings.style.selectedBarHeight = 3.0
        
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarMinimumLineSpacing = 10
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        
    }
    
}
