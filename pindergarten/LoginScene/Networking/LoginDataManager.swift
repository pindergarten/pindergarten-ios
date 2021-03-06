//
//  LoginDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/30.
//

import Alamofire

class LoginDataManager {
    func login(_ parameters: LoginRequest, delegate: NewSplashController) {
        AF.request("\(Constant.BASE_URL)/api/users/sign-in", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if response.isSuccess, let result = response.result {
                        delegate.didSuccessLogin(result)
                    }
                    else {
                        switch response.code {

                        default:  delegate.failedToLogin(message: response.message)
                        }
                    }
                case .failure(let error):
                    delegate.failedToLogin(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
