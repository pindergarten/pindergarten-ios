//
//  GetMyPageDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/24.
//

import Alamofire

class GetMyPageDataManager {
    func getMyPage(delegate: MeAndPetViewController) {
        AF.request("\(Constant.BASE_URL)/api/users/post", method: .get, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: GetMyPageResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let posts = response.posts, let user = response.user {
                        delegate.didSuccessGetMyPage(posts: posts, user: user)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToGetAllMyPage(message: "게시물 불러오기에 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetAllMyPage(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

