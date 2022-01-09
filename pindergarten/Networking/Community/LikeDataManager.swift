//
//  LikeDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/04.
//

import Alamofire

class LikeDataManager {
    
    func like(postId: Int, delegate: DetailFeedViewController) {
        AF.request("\(Constant.BASE_URL)/api/posts/\(postId)/like", method: .post,headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: LikeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didSuccessLike(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToLike(message: "")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToLike(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func like(postId: Int, index: Int, delegate: HomeViewController) {
        AF.request("\(Constant.BASE_URL)/api/posts/\(postId)/like", method: .post,headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: LikeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        print("DEBUG: SUCCESS LIKED")
                        delegate.didSuccessLike(idx: index, result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToLike(message: "")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToLike(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
