//
//  WithdrawalDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/25.
//

import Alamofire

class WithdrawalDataManager {
    func withdrawal(userId: Int, delegate: MyProfileController) {
        AF.request("\(Constant.BASE_URL)/api/users/\(userId)/status", method: .patch, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: DefaultResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessWithdrawal()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToWithdrawal(message: "회원탈퇴에 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToWithdrawal(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func withdrawal(userId: Int, delegate: SettingController) {
        AF.request("\(Constant.BASE_URL)/api/users/\(userId)/status", method: .patch, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: DefaultResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessWithdrawal()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToWithdrawal(message: "회원탈퇴에 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToWithdrawal(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
