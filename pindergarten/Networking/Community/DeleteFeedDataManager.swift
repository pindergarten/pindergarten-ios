//
//  DeleteFeedDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/05.
//

import Alamofire

class DeleteFeedDataManager {

    func deleteFeed(postId: Int, delegate: DetailFeedViewController) {
        AF.request("\(Constant.BASE_URL)/api/posts/\(postId)", method: .delete, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: DeleteFeedResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessDeleteFeed()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToDeleteFeed(message: "게시글 삭제에 실패하셨습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToDeleteFeed(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
