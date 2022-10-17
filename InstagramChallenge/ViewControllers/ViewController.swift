//
//  ViewController.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/25.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: 텍스트필드
    var inputPW = false
    var realPWString = ""
    var closePWString = ""
    
    @IBOutlet weak var loginIdTF: UITextField!
    @IBOutlet weak var loginPasswordTF: UITextField!
    
    // 아이디
    @IBAction func loginIdTFChange(_ sender: Any) {
        //inputPW = false
        checkMaxLength(textField: loginIdTF, maxLength: 20)
        checkClearId(textField: loginIdTF)
    }
    
    // 비밀번호
    @IBAction func loginPasswordTFChange(_ sender: Any) {
        //inputPW = true
        checkMaxLength(textField: loginPasswordTF, maxLength: 20)
        checkClearPw(textField: loginPasswordTF)
    }
    
    // 글자수 제한
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
    
    //아이디 1자리 이상 입력 시 다음 버튼 색 진하게 변경
    func checkClearId(textField: UITextField!){
        if textField.text?.count == 0 {
            loginButton.layer.opacity = 0.3
            loginButton.isEnabled = false
        } else {
            loginButton.layer.opacity = 1
            loginButton.isEnabled = true
        }
    }
    
    func checkClearPw(textField: UITextField!){
        if textField.text?.count == 0 {
            realPWString = ""
            closePWString = ""
            loginButton.layer.opacity = 0.3
            loginButton.isEnabled = false
        } else {
            loginButton.layer.opacity = 1
            loginButton.isEnabled = true
        }
    }
    
    // MARK: eye 버튼 -> 추후 수정 (완)
    var isEyeIconClick = false
    
    @IBOutlet weak var eyeIcon: UIButton!
    
    @IBAction func tapEyeIcon(_ sender: UIButton) {
        if !isEyeIconClick{ //오픈아이라면
            isEyeIconClick = true
            loginPasswordTF.text = realPWString
            eyeIcon.setImage(UIImage(named: "오픈아이"), for: .normal)
        }
        else { //클로즈아이라면
            isEyeIconClick = false
            loginPasswordTF.text = closePWString
            eyeIcon.setImage(UIImage(named: "클로즈아이"), for: .normal)
        }
    }
    
    // MARK: 로그인 버튼
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var kakaoLoginButton: UIButton!
    
    @IBAction func tapSignInButton(_ sender: UIButton) {
        let regex = "(?=.*[?!@#$%^&₩*()_+=-])"
        //let regex = "(?=.*[-/:;()&@".,?!'[]{}#%^*+=_\|~<>$£¥•.,?!'])"
        
        if (realPWString.range(of: regex, options: .regularExpression) != nil){
            print("특문 있습니다.")
        }else {
            print("특문 없습니다.")
        }
        
        //유효성 검사
        guard let idCount = loginIdTF.text?.count,
              let pwCount = loginPasswordTF.text?.count,
              idCount >= 3, idCount <= 20, pwCount >= 6, pwCount <= 20,
              (realPWString.range(of: regex, options: .regularExpression) != nil) else {
            
            presentLoginAlter(id: loginIdTF.text)
            return
        }
        
        let request = SignInRequest(loginId: loginIdTF.text!, password: realPWString)
        SignInDataManager().postSignIn(request, delegate: self)
    }
    
    @IBAction func tapKakaoSignInButton(_ sender: UIButton) {
        KakaoLoginManager().kakaoLogin(self)
    }
    
    
    // MARK: 회원가입 버튼
    @IBAction func tapSignUpButton(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginIdTF.returnKeyType = .next
        loginIdTF.delegate = self
        
        loginPasswordTF.returnKeyType = .done
        loginPasswordTF.delegate = self
    }
    
}

extension ViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if inputPW {
            print("비밀번호 선택")
            if !string.isEmpty{
                print(string)
                if realPWString.count < 20 {
                    realPWString += string
                    closePWString = String(repeating: "⬤", count: realPWString.count)
                    
                    // closePWString 값은 그대로하고 뷰에서 보이는 것만 realPWString.count "- 1" 해줌
                    // 빈 문자열에서 문자 추가하면 ⬤이 2개로 나옴(이유 모름 ㅠ)
                    let pw = String(repeating: "⬤", count: realPWString.count - 1)
                    
                    if isEyeIconClick{
                        loginPasswordTF.text = realPWString
                    } else {
                        loginPasswordTF.text = pw
                    }
                    
                    print("realPWString : \(realPWString)")
                    print("closePWString \(closePWString)")
                }
            }
            else { // isEmpty 인 경우 백스페이스 값
                let pw = String(repeating: "⬤", count: realPWString.count)
                
                realPWString.removeLast()
                closePWString.removeLast()
                
                print("realPWString : \(realPWString)")
                print("closePWString \(closePWString)")
                
                if isEyeIconClick{
                    loginPasswordTF.text = realPWString
                } else {
                    loginPasswordTF.text = pw
                }
            }
        } else {
            print("아이디 선택")
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == loginIdTF{
            inputPW = false
        }
        if textField == loginPasswordTF{
            inputPW = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginIdTF{
            loginIdTF.resignFirstResponder()
            loginPasswordTF.becomeFirstResponder()
        }
        if textField == loginPasswordTF{
            self.tapSignInButton(self.loginButton)
        }
        return true
    }
    
}


