//
//  SignUpDataManager.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/08/01.
//


import Foundation
import Alamofire

final class SignUpDataManager {
    
    // 매개변수(parameters)에 서버로 보낼 정보를 받아서 처리한다.
    func postSignUp(_ parameters: SignUpRequest, delegate: ConfirmLastViewController) {
        
        let url = "\(Constant.requestURL)/app/sign-up"
        
        print("parameters :\(parameters)")
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder(),
                   headers: nil)
        .validate()
        .responseDecodable(of: SignUpResponse.self) { response in
            
            switch response.result {
                // 네트워킹 성공
            case .success(let response):
                print(response)
                // 로그인 성공
                if response.isSuccess {
                    print("로그인 성공")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "RootViewController")
                    
                    // 토큰값 유저디폴트에 저장
                    UserDefaults.standard.set(response.result?.loginId, forKey: "userID")
                    UserDefaults.standard.set(response.result?.jwt, forKey: "jwt")
                    
                    Constant.isUserLogged = true
                    Constant.jwt = response.result?.jwt
                    Constant.loginID = ConfirmLastViewController.receiveId
                    
                    print("로그인 아이디 : \(ConfirmLastViewController.receiveId!)")
                    
                    delegate.changeRootViewController(vc)
                }
                else{
                    switch response.code {
                    case 2103: print("계정 아이디를 입력해주세요")
                    case 2104: print("계정 아이디는 20자리 미만으로 입력해주세요.")
                    case 2106: print("비밀번호를 입력 해주세요.")
                    case 2107: print("비밀번호는 20자리 미만으로 입력해주세요.")
                    case 2111: print("생일을 올바르게 입력 해주세요.")
                    case 2112: print("번호를 입력 해주세요.")
                    case 2113: print("번호를 11자리 미만으로 입력해주세요.")
                    case 2114: print("핸드폰 번호를 숫자만으로 입력해주세요.")
                    case 2115: print("아이디를 숫자와 영문으로만 입력해주세요.")
                    case 2116: print("실명을 입력 해주세요.")
                    case 2117: print("실명을 20자 미만으로 입력해주세요.")
                    case 2230: print("중복된 아이디입니다.")
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
                do{
                    let result = try JSONDecoder().decode(SignUpResponse.self, from: response.data!)
                    print("실패 result : \(result)")
                    
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
                print(error.localizedDescription)
            }
            
        }
    }
    
}
