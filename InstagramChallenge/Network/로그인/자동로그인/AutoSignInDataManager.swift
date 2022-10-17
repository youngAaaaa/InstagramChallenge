//
//  AutoSignInDataManager.swift
//  InstagraChallenge
//
//  Created by 안다영 on 2022/08/07.
//

import Foundation
import Alamofire

final class AutoSignInDataManager: UIViewController {
    
    func jwtCheck() {
        let url = "\(Constant.requestURL)/app/auto-sign-in"
        
        let header: HTTPHeaders = [
            "x-access-token": Constant.jwt ?? ""
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: header)
        .responseDecodable(of: AutoSignInResponse.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    print("자동로그인 성공")
                    
                    Constant.isUserLogged = true
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    guard let initialVC = storyboard.instantiateViewController(withIdentifier: "RootViewController") as? UITabBarController else {
                        return
                    }
                    self.changeRootViewController(initialVC)
                }else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    guard let initialVC = storyboard.instantiateViewController(withIdentifier: "InitialViewController") as? UINavigationController else {
                        return
                    }
                    self.changeRootViewController(initialVC)
                    
                    switch response.code {
                    case 3000: print("자동로그인 검증에 실패하였습니다. 다시 시도해주세요.")
                    case 3001: print("자동로그인이 만료되었습니다. 다시 로그인해주세요.")
                    default: UserDefaults.standard.set("", forKey: "jwt")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                print("자동로그인 네트워킹 실패")
            }
        }
        
        // jwt토큰 유효성 검사가 끝나면 세마포어 시그널
        Constant.semaphore.signal()
    }
}
