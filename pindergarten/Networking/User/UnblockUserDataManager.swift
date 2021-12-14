//
//  UnblockUserDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/12/14.
//

import Alamofire

class UnblockUserDataManager {
    func unblockUser(userId: Int, delegate: BlockUserController) {
        AF.request("\(Constant.BASE_URL)/api/users/\(userId)/unblock", method: .post, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: DefaultResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessUnblockUser()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToUnblockUser(message: response.message)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToUnblockUser(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
