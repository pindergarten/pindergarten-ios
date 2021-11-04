//
//  GetDetailFeedDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/03.
//

import Alamofire

class GetDetailFeedDataManager {
    func getADetailFeed(postId: Int, delegate: DetailFeedViewController) {
        AF.request("\(Constant.BASE_URL)/api/posts/\(postId)", method: .get, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: DetailFeedResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.post {
                        delegate.didSuccessGetDetailFeed(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToGetDetailFeed(message: "")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetDetailFeed(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
