//
//  DeleteCommentDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/06.
//

import Alamofire

class DeleteCommentDataManager {

    func deleteComment(postId: Int, commentId: Int,delegate: CommentController) {
        AF.request("\(Constant.BASE_URL)/api/posts/\(postId)/comments/\(commentId)", method: .delete, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: DeleteCommentResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessDeleteComment()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToDeleteComment(message: "댓글 삭제에 실패하셨습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToDeleteComment(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
