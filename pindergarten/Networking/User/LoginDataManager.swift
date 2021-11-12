//
//  LoginDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/30.
//

import Alamofire

class LoginDataManager {
    func login(_ parameters: LoginRequest, delegate: LoginViewController) {
        AF.request("\(Constant.BASE_URL)/api/users/sign-in", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didSuccessLogin(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToLogin(message: "전화번호와 비밀번호를 확인해주세요")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToLogin(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
