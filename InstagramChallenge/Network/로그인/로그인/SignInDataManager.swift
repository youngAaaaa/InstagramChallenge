//
//  SignInDataManager.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/31.
//

import UIKit
import Foundation
import Alamofire

final class SignInDataManager {
    
    // 매개변수(parameters)에 서버로 보낼 정보를 받아서 처리한다.
    func postSignIn(_ parameters: SignInRequest, delegate: UIViewController) {
        
        let url = "\(Constant.requestURL)/app/sign-in"
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder(),
                   headers: nil)
        .validate()
        .responseDecodable(of: SignInResponse.self) { response in
            switch response.result {
                // 네트워킹 성공
            case .success(let response):
                // 로그인 성공
                if response.isSuccess {
                    print("로그인 성공")
                    guard let rootVC = delegate.storyboard?.instantiateViewController(withIdentifier: "RootViewController") as? UITabBarController else {
                        return
                    }
                    // 토큰값 유저디폴트에 저장
                    UserDefaults.standard.set(response.result?.jwt, forKey: "jwt")
                    UserDefaults.standard.set(response.result?.loginId, forKey: "userID")
                    
                    Constant.isUserLogged = true
                    Constant.jwt = response.result?.jwt
                    Constant.loginID = response.result?.loginId
                    
                    delegate.changeRootViewController(rootVC)
                }
                else{
                    delegate.presentLoginAlter(id:parameters.loginId)
                    
                    switch response.code {
                    case 2103: print("계정 아이디를 입력해주세요")
                    case 2104: print("계정 아이디는 20자리 미만으로 입력해주세요.")
                    case 2106: print("비밀번호를 입력 해주세요.")
                    case 2107: print("비밀번호는 20자리 미만으로 입력해주세요.")
                    case 4002: print("비밀번호는 20자리 미만으로 입력해주세요.")
                    case 2232: print("아이디가 잘못 되었습니다.")
                    case 2233: print("비밀번호가 잘못 되었습니다.")
                    case 4000: print("데이터 베이스 커넥션 에러")
                    case 4001: print("서버 에러")
                    case 4002: print("데이터 베이스 쿼리 에러")
                    default: print("default")
                    }
                }
                // 네트워킹 실패
            case .failure(let error):
                delegate.presentLoginAlter(id: parameters.loginId)
                print(error.localizedDescription)
            }
            
        }
    }
}
