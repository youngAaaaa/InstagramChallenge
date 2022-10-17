//
//  InputAuthNumViewController.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/27.
//

import UIKit

class InputAuthNumViewController: UIViewController {
    
    // MARK: 전화번호 라벨
    var receivePhoneNumber = ""
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    
    // MARK: 인증코드 텍스트필드
    @IBOutlet weak var authCodeTF: UITextField!
    
    @IBAction func authCodeTFChange(_ sender: UITextField) {
        checkMaxLength(textField: authCodeTF, maxLength: 6)
        checkClear(textField: authCodeTF)
        checkAuthCode(textField: authCodeTF)
    }
    
    //숫자만 입력 가능
    let charSet: CharacterSet = {
        var cs = CharacterSet.lowercaseLetters
        cs.insert(charactersIn: "0123456789")
        return cs.inverted /* invert함으로써 허용되지 않은 문자로 구성된 CharacterSet이 return
                            허용되지 않는 문자를 검사하는게 빠르기 때문 */
    }()
    
    // 글자수 제한
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
    
    //인증코드 6자리 이상 입력 시 다음 버튼 색 진하게 변경
    func checkClear(textField: UITextField!){
        if textField.text?.count == 0 {
            nextButton.layer.opacity = 0.3
            nextButton.isEnabled = false
        }
        if textField.text?.count == 6 {
            nextButton.layer.opacity = 1
        }
    }
    
    // 인증코드가 123456인 경우
    func checkAuthCode(textField: UITextField!){
        if textField.text == "123456"{
            nextButton.isEnabled = true
        }
        else{
            nextButton.isEnabled = false
        }
    }
    
    
    
    // MARK: 전화번호 변경 버튼
    @IBAction func tapChangePhoneNumberButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: 다음 버튼
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "AddNameNavigationController") as? UINavigationController else { return }
        
        ConfirmLastViewController.receivePhoneNumber = receivePhoneNumber
        
        self.changeRootViewController(vc)
    }
    
    
    // MARK: 돌아가기 버튼
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authCodeTF.attributedPlaceholder = NSAttributedString(string: "인증코드", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        
        nextButton.layer.opacity = 0.3
        nextButton.layer.cornerRadius = 10
        nextButton.isEnabled = false
        
        authCodeTF.delegate = self
        authCodeTF.clearButtonMode = .always
        authCodeTF.keyboardType = .numberPad
        
        phoneNumberLabel.text = "+82\(String(Array(receivePhoneNumber)[1..<receivePhoneNumber.count]))번으로"
    }
    
    
}
extension InputAuthNumViewController: UITextFieldDelegate{
    
    //숫자만 입력
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !string.isEmpty{ // isEmpty 인 경우 백스페이스 값
            guard string.rangeOfCharacter(from: charSet) == nil else{
                return false
            }
        }
        return true
    }
}
