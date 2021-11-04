//
//  CheckUserDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/30.
//

import Alamofire

class CheckUserDataManager {
    func checkUser(_ parameters: CheckUserRequest, delegate: SignUpNumberViewController) {
        AF.request("\(Constant.BASE_URL)/api/users/phone", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: CheckUserResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessCheckUser()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2003: delegate.failedToCheckUser(message: "중복된 핸드폰 번호입니다.")
                        default: delegate.failedToCheckUser(message: "피드백을 주세요")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToCheckUser(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func checkUser(_ parameters: CheckUserRequest, delegate: FindPasswordViewController) {
        AF.request("\(Constant.BASE_URL)/api/users/phone", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: CheckUserResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessCheckUser()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2003: delegate.failedToCheckUser(message: "중복된 핸드폰 번호입니다")
                        default: delegate.failedToCheckUser(message: "")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToCheckUser(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
