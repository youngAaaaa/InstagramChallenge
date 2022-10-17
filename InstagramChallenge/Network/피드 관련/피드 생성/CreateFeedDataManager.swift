//
//  CreateFeedDataManager.swift
//  InstagraChallenge
//
//  Created by 안다영 on 2022/08/06.
//

import Foundation
import Alamofire

final class CreateFeedDataManager {
    
    func postFeed(_ parameters: CreateFeedRequest, delegate: PostingViewController) {
        
        let url = "\(Constant.requestURL)/app/feed"
        
        let header: HTTPHeaders = [
            "x-access-token": Constant.jwt!
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder(),
                   headers: header)
        .validate()
        .responseDecodable(of: CreateFeedResponse.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
                    delegate.changeRootViewController(vc)
                }
                else{
                    switch response.code {
                    case 2000: print("JWT 토큰을 입력해주세요.")
                    case 2902: print("페이지피드 문구는 최소 1자부터 최대 1000자 이내로 입력해야합니다.")
                    case 2903: print("페이지피드 컨텐츠는 최소 1장부터 최대 5장 이내로 선택해야합니다.")
                    case 3000: print("자동로그인 검증에 실패하였습니다. 다시 시도해주세요.")
                    case 3001: print("자동로그인이 만료되었습니다. 다시 로그인해주세요.")
                    case 4000: print("데이터 베이스 커넥션 에러")
                    case 4001: print("서버 에러")
                    case 4002: print("데이터 베이스 쿼리 에러")
                    default: print("default")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
}
