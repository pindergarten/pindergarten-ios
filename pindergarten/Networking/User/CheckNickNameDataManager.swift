//
//  CheckNickNameDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/30.
//

import Alamofire

class CheckNickNameDataManager {
    func checkNickName(_ parameters: CheckNickNameRequest, delegate: NickNameViewController) {
        AF.request("\(Constant.BASE_URL)/api/users/nickname", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: CheckNickNameResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessCheckNickName()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2015: delegate.failedToCheckNickName(message: "*이 계정 이름은 이미 다른 사람이 사용하고 있습니다.")
                        default: delegate.failedToCheckNickName(message: "")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToCheckNickName(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

