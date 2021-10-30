//
//  SendAuthNumberDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/30.
//

import Alamofire

class SendAuthNumberDataManager {
    func sendAuthNumber(_ parameters: SendAuthNumberRequest, delegate: SignUpNumberViewController) {
        AF.request("\(Constant.BASE_URL)/api/users/sms-send", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: SendAuthNumberResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess{
                        delegate.didSuccessSendAuthNumber()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2000: delegate.failedToSendAuthNumber(message: "상황에 맞는")
                        case 3000: delegate.failedToSendAuthNumber(message: "에러 메시지로")
                        case 4000: delegate.failedToSendAuthNumber(message: "사용자에게 적절한")
                        default: delegate.failedToSendAuthNumber(message: "피드백을 주세요")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToSendAuthNumber(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func sendAuthNumber(_ parameters: SendAuthNumberRequest, delegate: FindPasswordViewController) {
        AF.request("\(Constant.BASE_URL)/api/users/sms-send", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: SendAuthNumberResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess{
                        delegate.didSuccessSendAuthNumber()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToSendAuthNumber(message: "피드백을 주세요")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToSendAuthNumber(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
