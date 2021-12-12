//
//  GetCommentDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/04.
//

import Alamofire

class GetCommentDataManager {
    func getComment( postId: Int, delegate: CommentController) {
        AF.request("\(Constant.BASE_URL)/api/posts/\(postId)/comments", method: .get, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: GetCommentResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.comments {
                       
                        delegate.didSuccessGetComment(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToGetComment(message: "")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetComment(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
