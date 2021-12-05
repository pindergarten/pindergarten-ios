//
//  GetMyProfileDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/25.
//

import Alamofire

class GetMyProfileDataManager {
    func getMyProfile(userId: Int, delegate: MyProfileController) {
        AF.request("\(Constant.BASE_URL)/api/users/\(userId)", method: .get, headers: nil)
            .validate()
            .responseDecodable(of: GetMyProfileResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let user = response.user {
                        delegate.didSuccessGetMyProfile(user)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToGetMyProfile(message: response.message)
                        }
                    }
                   
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetMyProfile(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func getMyProfile(userId: Int, delegate: UserPageController) {
        AF.request("\(Constant.BASE_URL)/api/users/\(userId)", method: .get, headers: nil)
            .validate()
            .responseDecodable(of: GetMyProfileResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let user = response.user {
                        delegate.didSuccessGetMyProfile(user)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToGetMyProfile(message: response.message)
                        }
                    }
                   
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetMyProfile(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
