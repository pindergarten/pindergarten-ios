//
//  GetMyProfileDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/25.
//

import Alamofire

class GetMyProfileDataManager {
    func getMyProfile(userId: Int, delegate: UserProfileController) {
        AF.request("\(Constant.BASE_URL)/api/users/\(userId)", method: .get, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: GetUserResult.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                   
                    delegate.didSuccessGetMyProfile(response)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetMyProfile(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
