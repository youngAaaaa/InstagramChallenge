//
//  AddNameViewController.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/29.
//

import UIKit

class AddNameViewController: UIViewController {
    
    var receivePhoneNumber = ""
    var receiveName = ""
    
    // MARK: 이름 텍스트필드
    @IBOutlet weak var nameTF: UITextField!
    
    @IBAction func nameTFChange(_ sender: UITextField) {
        checkMaxLength(textField: nameTF, maxLength: 20)
        checkClear(textField: nameTF)
    }
    
    // 글자수 제한
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
    
    //이름 1자리 이상 입력 시 다음 버튼 색 진하게 변경
    func checkClear(textField: UITextField!){
        if textField.text?.count == 0 {
            nextButton.layer.opacity = 0.3
            nextButton.isEnabled = false
        } else {
            nextButton.layer.opacity = 1
            nextButton.isEnabled = true
        }
    }
    
    // MARK: 다음 버튼
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        ConfirmLastViewController.receiveName = nameTF.text
        
        if Constant.isUserKakaoLogged{
            let vc = AddBirthViewController(nibName:"AddBirthViewController", bundle: nil)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = MakePasswordViewController(nibName:"MakePasswordViewController", bundle: nil)
            
            self.changeRootViewController(vc)
        }
    }
    
    // MARK: 로그인 버튼
    @IBAction func tapLoginButton(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "InitialViewController") else { return }
        self.changeRootViewController(vc)
    }
    
    // MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    // MARK: configureView()
    func configureView(){
        // 이름 텍스트필드 설정
        nameTF.attributedPlaceholder = NSAttributedString(string: "이름", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        nameTF.clearButtonMode = .always
        
        // 다음 버튼
        nextButton.layer.opacity = 0.3
        nextButton.layer.cornerRadius = 10
        nextButton.isEnabled = false
    }
    
}
