//
//  GetUserPetsDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/12/05.
//

import Alamofire

class GetUserPetsDataManager {
    
    
    func getUserPet(userId: Int, delegate: UserPageController) {
        AF.request("\(Constant.BASE_URL)/api/users/\(userId)/pet", method: .get, headers: nil)
            .validate()
            .responseDecodable(of: GetUserPetsResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.pets {
                        delegate.didSuccessGetAllUserPets(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToGetUserPets(message: response.message)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetUserPets(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

