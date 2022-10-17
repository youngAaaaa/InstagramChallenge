//
//  ConfirmLastViewController.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/08/01.
//

import UIKit

class ConfirmLastViewController: UIViewController {
    
    static var receiveName: String?
    static var receivePassword: String?
    static var receiveId: String?
    static var receiveBirthDate: String?
    static var receivePhoneNumber: String?
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    

    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        print(ConfirmLastViewController.receiveName!)
        print(ConfirmLastViewController.receiveId!)
        print(ConfirmLastViewController.receiveBirthDate!)
        print(ConfirmLastViewController.receivePhoneNumber!)
        if !Constant.isUserKakaoLogged{
        print(ConfirmLastViewController.receivePassword!)
        }
        
        if Constant.isUserKakaoLogged{
            let request = KakaoSignUpRequest(accessToken: Constant.kakaoOauthToken!,
                                             realName: ConfirmLastViewController.receiveName!,
                                             loginId: ConfirmLastViewController.receiveId!,
                                             birthDate: ConfirmLastViewController.receiveBirthDate!,
                                             phoneNumber: ConfirmLastViewController.receivePhoneNumber!)
            
            SocialLoginDataManager().postSignUp(request, delegate: self)
        }
        else{
            let request = SignUpRequest(realName: ConfirmLastViewController.receiveName!,
                                        password: ConfirmLastViewController.receivePassword!,
                                        loginId: ConfirmLastViewController.receiveId!,
                                        birthDate: ConfirmLastViewController.receiveBirthDate!,
                                        phoneNumber: ConfirmLastViewController.receivePhoneNumber!)
            
            SignUpDataManager().postSignUp(request, delegate: self)
        }
    }
    
    @IBAction func tapLoginButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "InitialViewController")
        self.changeRootViewController(vc)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    // MARK: configureView()
    func configureView(){
        dismissKeyboardWhenTappedAround()
        
        mainLabel.numberOfLines = 0
        mainLabel.text = "\(ConfirmLastViewController.receiveId!)\n 님으로 가입하시겠어요?"
        
        subLabel.numberOfLines = 0
        subLabel.text = "나중에 언제든지 사용 이름을 변경할 수 있습니다."
        
        nextButton.layer.cornerRadius = 10
    }

}
