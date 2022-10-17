//
//  MakePasswordViewController.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/27.
//

import UIKit

class MakePasswordViewController: UIViewController {
    
    // MARK: 패스워드 텍스트필드
    var realPWString = ""
    var closePWString = ""
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBAction func passwordTFChange(_ sender: UITextField) {
        checkMaxLength(textField: passwordTF, maxLength: 20)
        checkClear(textField: passwordTF)
    }
    
    // 글자수 제한
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
    
    //비번 1자리 이상 입력 시 다음 버튼 색 진하게 변경
    func checkClear(textField: UITextField!){
        if textField.text?.count == 0 {
            nextButton.layer.opacity = 0.3
            nextButton.isEnabled = false
            
            realPWString = ""
            closePWString = ""
        } else {
            nextButton.layer.opacity = 1
            nextButton.isEnabled = true
        }
    }
    
    
    // MARK: 다음 버튼
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        
        let regex = "(?=.*[?!~@#$%^&₩*()_+=-]).{6,20}"
        
        guard (realPWString.range(of: regex, options: .regularExpression) != nil) else {
            self.presentAlert(title: "비밀번호를 확인해주세요.")
            return
        }
        
        ConfirmLastViewController.receivePassword = realPWString
        
        let vc = AddBirthViewController(nibName:"AddBirthViewController", bundle: nil)
        self.changeRootViewController(vc)
    }
    
    // MARK: 로그인 버튼
    @IBAction func tapLoginButton(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "InitialViewController") else { return }
        self.changeRootViewController(vc)
    }
    
    // MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        passwordTF.delegate = self
    }
    
    // MARK: configureView()
    func configureView(){
        // 이름 텍스트필드 설정
        passwordTF.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        passwordTF.clearButtonMode = .always
        
        // 다음 버튼
        nextButton.layer.opacity = 0.3
        nextButton.layer.cornerRadius = 10
        nextButton.isEnabled = false
    }
    
}
extension MakePasswordViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !string.isEmpty{
            if realPWString.count < 20 {
                realPWString += string
                closePWString = String(repeating: "⬤", count: realPWString.count)
                
                let pw = String(repeating: "⬤", count: realPWString.count - 1)
                
                passwordTF.text = pw
                
                print("realPWString : \(realPWString)")
                print("closePWString : \(closePWString)")
            }
        }
        else { // isEmpty 인 경우 백스페이스 값
            let pw = String(repeating: "⬤", count: realPWString.count)
            
            realPWString.removeLast()
            closePWString.removeLast()
            
            print("realPWString : \(realPWString)")
            print("closePWString : \(closePWString)")
            
            passwordTF.text = pw
        }
        return true
    }
}
