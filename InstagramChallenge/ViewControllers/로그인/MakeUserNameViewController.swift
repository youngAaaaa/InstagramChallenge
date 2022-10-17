//
//  MakeUserNameViewController.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/08/01.
//

import UIKit

class MakeUserNameViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    // MARK: 텍스트필드
    @IBOutlet weak var userName: UITextField!
    @IBAction func userNameTFChange(_ sender: Any) {
        checkMaxLength(textField: userName, maxLength: 20)
        
        //        clearButton.setImage(UIImage(named: "클리어버튼"), for: .normal)
        //        clearButton.isEnabled = true
        
        checkUserName.isHidden = true
        userName.layer.borderWidth = 0
        userName.layer.borderColor = UIColor.gray.cgColor
    }
    
    // 글자수 제한
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
    
    @IBOutlet weak var checkUserName: UILabel!
    
    // MARK: 클리어 버튼
    @IBOutlet weak var clearButton: UIButton!
    @IBAction func tapClearButton(_ sender: UIButton) {
        userName.text = ""
        checkUserName.text = ""
        userName.layer.borderWidth = 0
        userName.layer.borderColor = UIColor.gray.cgColor
    }
    
    // MARK: 다음 버튼
    var checkNext = false
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func tapNextButton(_ sender: UIButton) {
        
        userName.layer.borderWidth = 0
        userName.layer.borderColor = UIColor.gray.cgColor
        checkUserName.isHidden = false
        var name = userName.text
        name = name!.filter({
            !$0.isLowercase && !$0.isNumber && $0 != "_" && $0 != "."
        })
        
        guard let count = name?.count, count == 0 else {
            checkUserName.text = "아이디는 영어, 숫자, '_', '.' 만 사용 가능합니다."
            userName.layer.borderWidth = 1
            userName.layer.cornerRadius = 5
            userName.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        DuplicateIdDataManager().checkDuplicate(delegate: self)
        
        if checkNext {
            let vc = ConfirmLastViewController(nibName:"ConfirmLastViewController", bundle: nil)
            ConfirmLastViewController.receiveId = userName.text
            changeRootViewController(vc)
        }
    }
    
    // MARK: 로그인 버튼
    @IBAction func tapLoginButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "InitialViewController")
        self.changeRootViewController(vc)
    }
    
    // MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        userName.delegate = self
    }
    
    // MARK: configureView()
    func configureView(){
        dismissKeyboardWhenTappedAround()
        
        label.numberOfLines = 0
        label.text = "새 계정에 사용할 사용자 이름을 선택하세요. 나중에\n 언제든지 변경할 수 있습니다."
        
        nextButton.layer.cornerRadius = 10
        
        clearButton.isHidden = true
        checkUserName.isHidden = true
        
        userName.attributedPlaceholder = NSAttributedString(string: "사용자 이름", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
    }
    
}

extension MakeUserNameViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        clearButton.setImage(UIImage(named: "클리어버튼"), for: .normal)
        clearButton.isEnabled = true
        clearButton.isHidden = false
        checkUserName.isHidden = true
        
        userName.layer.borderWidth = 0
        userName.layer.borderColor = UIColor.gray.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //이름 입력란이 비어 있으면 버튼 사라짐
        if textField.text!.isEmpty{
            clearButton.isHidden = true
        } else { clearButton.isHidden = true }
    }
}
