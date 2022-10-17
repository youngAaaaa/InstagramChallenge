//
//  GetFeedDataManager.swift
//  InstagraChallenge
//
//  Created by 안다영 on 2022/08/06.
//

import Foundation
import Alamofire

final class GetFeedDataManager {
    
    func getFeed(delegate: HomeViewController) {
        
        let url = "\(Constant.requestURL)/app/feeds?pageIndex=\(delegate.pageIndex)&size=10"
        
        let header: HTTPHeaders = [
            "x-access-token": Constant.jwt ?? ""
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: header)
        .validate()
        .responseDecodable(of: GetFeedResponse.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    print("데이터 가져오기 성공")
                    delegate.feedDataList = response.result
                    delegate.refreshControl.endRefreshing()
                    delegate.mainTableView.reloadData()
                }
                else {
                    switch response.code {
                    case 2000: print("JWT 토큰을 입력해주세요.")
                    case 2900: print("페이지 인덱스를 올바르게 입력해주세요.")
                    case 2901: print("페이지 사이즈를 올바르게 입력해주세요.")
                    case 3000: print("자동로그인 검증에 실패하였습니다. 다시 시도해주세요.")
                    case 3001: print("자동로그인이 만료되었습니다. 다시 로그인해주세요.")
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
