//
//  RegisterUserDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/30.
//

import Alamofire

class RegisterUserDataManager {
    func registerUser(_ parameters: RegisterUserRequest, delegate: NickNameViewController) {
        AF.request("\(Constant.BASE_URL)/api/users", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: RegisterUserResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessRegisterUser()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        
                        default: delegate.failedToRegisterUser(message: "")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRegisterUser(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
