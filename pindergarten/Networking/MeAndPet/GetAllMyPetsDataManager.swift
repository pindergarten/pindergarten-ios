//
//  GetAllMyPetsDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/23.
//

import Alamofire

class GetAllMyPetsDataManager {
    func getAllMyPet(delegate: MeAndPetViewController) {
        AF.request("\(Constant.BASE_URL)/api/pets", method: .get, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: GetAllMyPetsResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.pets {
                        delegate.didSuccessGetAllMyPet(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToGetAllMyPet(message: "등록된 반려견들을 불러오기에 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetAllMyPet(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }

}
