//
//  SocialLoginDataManager.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/29.
//

import Foundation
import Alamofire


class SocialLoginDataManager {
    
    func postSignIn(_ parameters: KakaoLoginRequest, delegate: UIViewController) {
        
        print("‼️parameters : \(parameters)")
        let url = "\(Constant.requestURL)/app/kakao-sign-in"
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder(),
                   headers: nil)
        .validate()
        .responseDecodable(of: KakaoLoginResponse.self) { response in
            switch response.result {
            case .success(let response):
                Constant.kakaoOauthToken = parameters.accessToken
                print("‼️response : \(response)")
                // 회원인 경우
                if response.isSuccess {
                    print("카카오 로그인 성공 & 회원인 경우")
                    guard let rootVC = delegate.storyboard?.instantiateViewController(withIdentifier: "RootViewController") as? UITabBarController else {
                        return
                    }
                    
                    Constant.loginID = response.result?.loginId
                    Constant.isUserLogged = true
                    Constant.jwt = response.result?.jwt
                    
                    UserDefaults.standard.set(response.result?.loginId, forKey: "userID")
                    UserDefaults.standard.set(Constant.jwt!, forKey: "jwt")
                    delegate.changeRootViewController(rootVC)
                }
                // 회원이 아닌 경우
                else {
                    // 카카오 로그인은 성공한 경우
                    if Constant.isUserKakaoLogged {
                        print("카카오 로그인 성공 & 회원은 아님")
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        guard let rootVC = storyboard.instantiateViewController(withIdentifier: "PhoneEmailInputViewController") as? PhoneEmailInputViewController else { return }
                        
                        delegate.navigationController?.pushViewController(rootVC, animated: true)
                        
                        rootVC.presentAlert(title: "로그인에 실패하였습니다.")
                    }
                    switch response.code {
                    case 2100: print("카카오 계정이 존재하지 않습니다.")
                    case 2236: print("카카오 토큰이 잘못 되었습니다.")
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
    
    func postSignUp(_ parameters: KakaoSignUpRequest, delegate: ConfirmLastViewController) {
        
        print("‼️KakaoSignUpRequest parameters : \(parameters)")
        
        let url = "\(Constant.requestURL)/app/kakao-sign-up"
        
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
                
                // 로그인 성공
                if response.isSuccess {
                    print("로그인 성공")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    guard let rootVC = storyboard.instantiateViewController(withIdentifier: "RootViewController") as? UITabBarController else {
                        return
                    }
                    // 토큰값 유저디폴트에 저장
                    UserDefaults.standard.set(Constant.jwt, forKey: "jwt")
                    
                    Constant.isUserLogged = true
                    
                    Constant.loginID = ConfirmLastViewController.receiveId
                    
                    print("로그인 아이디 : \(ConfirmLastViewController.receiveId!)")
                    
                    delegate.changeRootViewController(rootVC)
                }
                else{
                    
                    switch response.code {
                    case 2100: print("카카오 계정이 존재하지 않습니다.")
                    case 2103: print("계정 아이디를 입력해주세요.")
                    case 2104: print("계정 아이디는 20자리 미만으로 입력해주세요.")
                    case 2111: print("생일을 올바르게 입력 해주세요.")
                    case 2113: print("번호를 11자리 미만으로 입력해주세요.")
                    case 2114: print("핸드폰 번호를 숫자만으로 입력해주세요.")
                    case 2115: print("아이디를 숫자와 영문으로만 입력해주세요.")
                    case 2116: print("실명을 입력 해주세요.")
                    case 2117: print("실명을 20자 미만으로 입력해주세요.")
                    case 2236: print("카카오 토큰이 잘못 되었습니다.")
                    case 2237: print("이미 카카오 계정이 존재합니다.")
                    case 4000: print("데이터 베이스 커넥션 에러")
                    case 4001: print("서버 에러")
                    case 4002: print("데이터 베이스 쿼리 에러")
                    default: print("default")
                    }
                }
                // 네트워킹 실패
            case .failure(let error):
                do{
                    let result = try JSONDecoder().decode(KakaoSignUpResponse.self, from: response.data!)
                    
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
