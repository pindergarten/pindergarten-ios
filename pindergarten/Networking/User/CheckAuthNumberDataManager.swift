//
//  CheckAuthNumberDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/30.
//

import Alamofire

class CheckAuthNumberDataManager {
    func checkAuthNumber(_ parameters: CheckAuthNumberRequest, delegate: SignUpNumberViewController) {
        AF.request("\(Constant.BASE_URL)/api/users/sms-verify", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: CheckAuthNumberResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessCheckAuthNumber()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2004: delegate.failedToCheckAuthNumber(message: "인증번호를 다시 입력해 주세요.")
                        default: delegate.failedToCheckAuthNumber(message: "")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToCheckAuthNumber(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func checkAuthNumber(_ parameters: CheckAuthNumberRequest, delegate: FindPasswordViewController) {
        AF.request("\(Constant.BASE_URL)/api/users/sms-verify", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: CheckAuthNumberResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessCheckAuthNumber()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2004: delegate.failedToCheckAuthNumber(message: "인증번호를 다시 입력해 주세요.")
                        default: delegate.failedToCheckAuthNumber(message: "")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToCheckAuthNumber(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
