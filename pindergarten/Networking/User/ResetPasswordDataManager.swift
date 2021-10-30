//
//  ResetPasswordDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/30.
//

import Alamofire

class ResetPasswordDataManager {
    func resetPassword(_ parameters: ResetPasswordRequest, delegate: ResetPasswordViewController) {
        AF.request("\(Constant.BASE_URL)/api/users/find-pw", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: ResetPasswordResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessResetPassword()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToResetPassword(message: "")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToResetPassword(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
