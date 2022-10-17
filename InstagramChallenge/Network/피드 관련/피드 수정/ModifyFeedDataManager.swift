//
//  ModifyFeedDataManager.swift
//  InstagraChallenge
//
//  Created by 안다영 on 2022/08/07.
//

import Foundation
import Alamofire


final class ModifyFeedDataManager {
    
    func updateFeed(_ delegate: ModifyViewController, parameters: ModifyFeedRequest, feedId: Int) {
        
        let url = "\(Constant.requestURL)/app/feeds/\(feedId)"

        let header: HTTPHeaders = [
            "x-access-token": Constant.jwt ?? ""
        ]

        AF.request(url,
                   method: .patch,
                   parameters: parameters,
                   headers: header)
        .validate()
        .responseDecodable(of: ModifyFeedResponse.self) { response in
            switch response.result {
            // 네트워킹 성공
            case .success(let response):
                if response.isSuccess {
                    print("‼️ feed 수정 성공")
                    guard let vc = delegate.storyboard?.instantiateViewController(identifier: "RootViewController") as? UITabBarController else { return }
                    delegate.changeRootViewController(vc)
                }
                else {
                    switch response.code {
                    case 2000: print("JWT 토큰을 입력해주세요.")
                    case 2904: print("피드 아이디를 올바르게 입력해주세요.")
                    case 2908: print("피드가 존재하지않습니다.")
                    case 2909: print("본인의 피드만 수정 가능합니다.")
                    case 3000: print("자동로그인 검증에 실패하였습니다. 다시 시도해주세요.")
                    case 3001: print("자동로그인이 만료되었습니다. 다시 로그인해주세요.")
                    case 4000: print("데이터 베이스 커넥션 에러")
                    case 4001: print("서버 에러")
                    case 4002: print("데이터 베이스 쿼리 에러")
                    default: print("")
                    }
                }
            // 네트워킹 실패
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
