//
//  SignUpViewController.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/25.
//

import UIKit

class SignUpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func tapKakaoLoginButton(_ sender: UIButton) {
        KakaoLoginManager().kakaoLogin(self)
    }
    
    
    
    @IBAction func tapSignUpButton(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PhoneEmailInputViewController") as? PhoneEmailInputViewController else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapLoginButton(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "InitialViewController") else { return }
        self.changeRootViewController(vc)
    }
}
