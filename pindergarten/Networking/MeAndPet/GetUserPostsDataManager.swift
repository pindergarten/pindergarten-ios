//
//  GetUserPostsDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/12/05.
//

import Alamofire

class GetUserPostsDataManager {
    
    
    func getUserPosts(userId: Int, delegate: UserPageController) {
        AF.request("\(Constant.BASE_URL)/api/users/\(userId)/post", method: .get, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: GetUserPostsResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.posts {
                        delegate.didSuccessGetUserPosts(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToGetUserPost(message: response.message)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetUserPost(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

