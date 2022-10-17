//
//  AddBirthViewController.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/27.
//

import UIKit

class AddBirthViewController: UIViewController {
    
    // MARK: 생일 추가 텍스트필드
    @IBOutlet weak var birthTF: UITextField!
    
    
    // MARK: 나이 라벨
    @IBOutlet weak var ageLabel: UILabel!
    
    
    // MARK: 다음 버튼
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        var date = birthTF.text!
        date = date.filter{
            $0.isNumber
        }
        print(date)
        
        date.insert(".", at: date.index(date.startIndex, offsetBy: 4))
        date.insert(".", at: date.index(date.startIndex, offsetBy: 7))
        print(date)
        
        ConfirmLastViewController.receiveBirthDate = date
        
        let vc = ConsentTermsViewController(nibName:"ConsentTermsViewController", bundle: nil)
        
        self.changeRootViewController(vc)
    }
    
    
    // MARK: datepicker
    
    private var today: String = ""
    private var birthDate: Date?
    let picker = UIDatePicker()
    
    private func createDatePicker(){
        picker.preferredDatePickerStyle = .wheels // datePickerstyle설정
        picker.datePickerMode = .date // datepicker 모드 설정
        picker.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 215)
        picker.locale = Locale(identifier: "Korean") // datepicker 언어 = 한국어
        picker.layer.backgroundColor = UIColor.white.cgColor
    }
    
    private func configureDatePicker(){
        self.picker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        
        self.birthTF.inputView = self.picker
    }
    
    //addTarget 두번째 파라미터 셀렉터 메서드
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker){
        let formmater = DateFormatter() // 데이트 타입을 사람이 읽을 수 있도록 사람이 변환을 해주거나, 날짜 타입에서 데이트 타입을 변환을시켜주는 역할
        formmater.dateFormat = "yyyy년 MM월 dd일" //데이트 포멧형식 잡기
        self.birthDate = datePicker.date // datePicker 에서 선택된 date값 넘기기
        let birthYear = formmater.string(from: picker.date)
        self.birthTF.text = birthYear // 포멧한 데이트 값을 텍스트 필드에 표시
        birthTF.textColor = .black
        
        let age = calcAge(birth: birthYear)
        
        if today < birthYear{
            ageLabel.isHidden = true
            nextButton.isEnabled = false
            nextButton.layer.opacity = 0.3
        } else {
            ageLabel.isHidden = false
            ageLabel.text = String(age) + "세"
            nextButton.isEnabled = true
            nextButton.layer.opacity = 1
        }
    }
    
    // MARK: calcAge()
    func calcAge(birth: String) -> Int {
        let currentYear = String(Array(today)[0...3])
        
        let birthYear = String(Array(birth)[0...3])
        
        let age: Int = Int(currentYear)! - Int(birthYear)! + 1
        
        return age
    }
    
    
    // MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 초기 날짜 설정
        defalutDate()
        
        
        birthTF.delegate = self
        
        createDatePicker()
        configureDatePicker()
        
        configureView()
    }
    
    
    // MARK: defalutDate()
    func defalutDate(){
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy년 M월 dd일"
        today = formmater.string(from: picker.date)
        birthTF.text = today
        birthTF.textColor = .lightGray
    }
    
    
    // MARK: configureView()
    func configureView(){
        ageLabel.isHidden = true
        nextButton.layer.cornerRadius = 10
        nextButton.layer.opacity = 0.3
        nextButton.isEnabled = false
    }
    
    
    
}

extension AddBirthViewController: UITextFieldDelegate{
}
