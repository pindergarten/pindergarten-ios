//
//  GetAllFeedDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/03.
//

import Alamofire

class GetAllFeedDataManager {
    func getAllFeed(delegate: PindergartenViewController) {
        AF.request("\(Constant.BASE_URL)/api/posts", method: .get, headers: nil)
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
                        default: delegate.failedToGetAllFeed(message: "")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetAllFeed(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}



