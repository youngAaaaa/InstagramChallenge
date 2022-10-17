//
//  DuplicateIdDataManager.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/08/01.
//


import UIKit
import Foundation
import Alamofire

final class DuplicateIdDataManager {
    
    func checkDuplicate(delegate: MakeUserNameViewController) {
        
        let url = "\(Constant.requestURL)/app/check-duplicate-login-id?loginId=\(delegate.userName.text!)"
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: nil)
        .validate()
        .responseDecodable(of: DuplicateIdResponse.self) { response in
            switch response.result {
                // 네트워킹 성공
            case .success(let response):
                // 로그인 성공
                if response.isSuccess {
                    delegate.clearButton.isEnabled = false
                    delegate.clearButton.setImage(UIImage(named: "체크"), for: .normal)
                    delegate.checkUserName.isHidden = true
                    delegate.userName.layer.borderWidth = 0
                    delegate.userName.layer.borderColor = UIColor.gray.cgColor
                    delegate.checkNext = true
                    
                }
                else{
                    delegate.clearButton.isHidden = false
                    
                    let name = delegate.userName.text!
                    delegate.checkUserName.isHidden = false
                    delegate.checkUserName.text = "사용자 이름 \(name)을(를) 사용할 수 없습니다."
                    delegate.userName.layer.borderWidth = 1
                    delegate.userName.layer.cornerRadius = 5
                    delegate.userName.layer.borderColor = UIColor.red.cgColor
                    
                    switch response.code {
                    case 2103: print("계정 아이디를 입력해주세요.")
                    case 2104: print("계정 아이디는 20자리 미만으로 입력해주세요.")
                    case 2230: print("중복된 아이디입니다.")
                    case 4000: print("데이터 베이스 커넥션 에러")
                    case 4001: print("서버 에러")
                    case 4002: print("데이터 베이스 쿼리 에러")
                    default: print("default")
                    }
                }
                // 네트워킹 실패
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}
