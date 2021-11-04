//
//  PostCommentDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/05.
//

import Alamofire

class PostCommentDataManager {
    
    func registerComment(postId: Int, _ parameters: PostCommentRequest, delegate: CommentController) {
        AF.request("\(Constant.BASE_URL)/api/posts/\(postId)/comments", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: PostCommentResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessRegisterComment()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToRegisterComment(message: "메시지 등록에 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRegisterComment(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
