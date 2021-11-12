//
//  GetAllFeedDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/03.
//

import Alamofire

class GetAllFeedDataManager {
    func getAllFeed(delegate: HomeViewController) {
        AF.request("\(Constant.BASE_URL)/api/posts", method: .get, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: AllFeedResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.allposts {
                        delegate.didSuccessGetAllFeed(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToGetAllFeed(message: "피드 불러오기에 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetAllFeed(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}



