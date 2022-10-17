//
//  ConsentTermsViewController.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/27.
//

import UIKit
import WebKit

class ConsentTermsViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    // MARK: 동의 버튼
    var allcheck = false
    var check1 = false
    var check2 = false
    var check3 = false
    
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    func settingFalse(){
        allButton.setImage(UIImage(named: "동의X"), for: .normal)
        allcheck = false
        nextButton.layer.opacity = 0.3
        nextButton.isEnabled = false
    }
    
    func checkButton(){
        allButton.setImage(UIImage(named: "동의O"), for: .normal)
        allcheck = true
        nextButton.layer.opacity = 1
        nextButton.isEnabled = true
    }
    
    @IBAction func tapAllButton(_ sender: UIButton) {
        if !allcheck{
            nextButton.layer.opacity = 1
            nextButton.isEnabled = true
            allButton.setImage(UIImage(named: "동의O"), for: .normal)
            button1.setImage(UIImage(named: "동의O"), for: .normal)
            button2.setImage(UIImage(named: "동의O"), for: .normal)
            button3.setImage(UIImage(named: "동의O"), for: .normal)
            
            allcheck = true
            check1 = true
            check2 = true
            check3 = true
            
        } else{
            nextButton.layer.opacity = 0.3
            nextButton.isEnabled = false
            allButton.setImage(UIImage(named: "동의X"), for: .normal)
            button1.setImage(UIImage(named: "동의X"), for: .normal)
            button2.setImage(UIImage(named: "동의X"), for: .normal)
            button3.setImage(UIImage(named: "동의X"), for: .normal)
            
            allcheck = false
            check1 = false
            check2 = false
            check3 = false
        }
    }
    
    @IBAction func tapButton1(_ sender: UIButton) {
        settingFalse()
        if !check1{
            button1.setImage(UIImage(named: "동의O"), for: .normal)
            check1 = true
        } else{
            button1.setImage(UIImage(named: "동의X"), for: .normal)
            check1 = false
        }
        if check1 && check2 && check3 { checkButton() }
    }
    
    @IBAction func tapButton2(_ sender: UIButton) {
        settingFalse()
        
        if !check2{
            button2.setImage(UIImage(named: "동의O"), for: .normal)
            check2 = true
        } else{
            button2.setImage(UIImage(named: "동의X"), for: .normal)
            check2 = false
        }
        if check1 && check2 && check3 { checkButton() }
    }
    
    @IBAction func tapButton3(_ sender: UIButton) {
        settingFalse()
        
        if !check3{
            button3.setImage(UIImage(named: "동의O"), for: .normal)
            check3 = true
        } else{
            button3.setImage(UIImage(named: "동의X"), for: .normal)
            check3 = false
        }
        if check1 && check2 && check3 { checkButton() }
    }
    
    
    // MARK: 더 알아보기
    
    func loadWebView(){
        let vc = WebViewController(nibName:"WebViewController", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func tapMore1(_ sender: UIButton) {
        loadWebView()
    }
    @IBAction func tapMore2(_ sender: UIButton) {
        loadWebView()
    }
    @IBAction func tapMore3(_ sender: UIButton) {
        loadWebView()
    }
    
    
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func tapNextButton(_ sender: UIButton) {
        let vc = MakeUserNameViewController(nibName:"MakeUserNameViewController", bundle: nil)
        self.changeRootViewController(vc)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView(){
        label.numberOfLines = 0
        label.text = "Instagram은 회원님의 개인 정보를 안전하게\n 보호합니다. 새 계정을 만들려면 모든 약관에\n 동의하세요."
        
        nextButton.layer.cornerRadius = 10
        nextButton.isEnabled = false
        nextButton.layer.opacity = 0.7
    }
    
}
