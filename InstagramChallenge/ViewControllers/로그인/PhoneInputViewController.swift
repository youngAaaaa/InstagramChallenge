//
//  PhoneInputViewController.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/25.
//

import UIKit
import XLPagerTabStrip

class PhoneInputViewController: UIViewController, IndicatorInfoProvider {
    // MARK: 텍스트 필드
    @IBOutlet weak var inputPhoneNumberTF: UITextField!
    @IBAction func inputPhoneNumberTFChange(_ sender: UITextField) {
        checkMaxLength(textField: inputPhoneNumberTF, maxLength: 11)
        checkClear(textField: inputPhoneNumberTF)
    }
    // 글자수 제한
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
    
    //폰 번호 1자리 이상 입력 시 다음 버튼 색 진하게 변경
    func checkClear(textField: UITextField!){
        if textField.text?.count == 0 {
            nextButton.layer.opacity = 0.3
            nextButton.isEnabled = false
            phoneNumPH.isHidden = false
        }
        else {
            nextButton.layer.opacity = 1
            nextButton.isEnabled = true
            phoneNumPH.isHidden = true
        }
    }
    
    //숫자만 입력 가능
    let charSet: CharacterSet = {
        var cs = CharacterSet.lowercaseLetters
        cs.insert(charactersIn: "0123456789")
        return cs.inverted /* invert함으로써 허용되지 않은 문자로 구성된 CharacterSet이 return
                            허용되지 않는 문자를 검사하는게 빠르기 때문 */
    }()
    
    // MARK: placeholder 대체
    @IBOutlet weak var phoneNumPH: UILabel!
    
    
    // MARK: 다음 버튼
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        let vc = InputAuthNumViewController(nibName:"InputAuthNumViewController", bundle: nil)
        vc.receivePhoneNumber = inputPhoneNumberTF.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapKakaoLoginButton(_ sender: UIButton) {
        KakaoLoginManager().kakaoLogin(self)
    }
    
    
    
    
    
    // MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        inputPhoneNumberTF.addLeftPadding()
        
        inputPhoneNumberTF.clearButtonMode = .always
        inputPhoneNumberTF.keyboardType = .numberPad
        inputPhoneNumberTF.delegate = self
        
        nextButton.isEnabled = false
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "전화번호")
    }
    
}

extension PhoneInputViewController: UITextFieldDelegate{
    
    //숫자만 입력
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !string.isEmpty{ // isEmpty 인 경우 백스페이스 값
            guard string.rangeOfCharacter(from: charSet) == nil else{
                return false
            }
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        phoneNumPH.isHidden = true
    }
}

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 110, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
