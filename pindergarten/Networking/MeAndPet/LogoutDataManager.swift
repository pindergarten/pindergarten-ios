//
//  LogoutDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/25.
//

import Alamofire

class LogoutDataManager {
    func logout(delegate: MyProfileController) {
        AF.request("\(Constant.BASE_URL)/api/users/sign-out", method: .patch, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: DefaultResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessLogout()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToLogout(message: "로그아웃에 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToLogout(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func logout(delegate: SettingController) {
        AF.request("\(Constant.BASE_URL)/api/users/sign-out", method: .patch, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: DefaultResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessLogout()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToLogout(message: "로그아웃에 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToLogout(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

