//
//  BlockUserDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/12/13.
//

import Alamofire

class BlockUserDataManager {
    func blockUser(userId: Int, delegate: UserPageController) {
        AF.request("\(Constant.BASE_URL)/api/users/\(userId)/block", method: .post, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: DefaultResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessBlockUser()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToBlockUser(message: response.message)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToBlockUser(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
