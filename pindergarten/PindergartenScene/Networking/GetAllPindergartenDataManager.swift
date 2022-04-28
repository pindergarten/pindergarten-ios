//
//  GetAllPindergartenDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/14.
//

import Alamofire

class GetAllPindergartenDataManager {
    func getAllPindergarten(lat: Double, lon: Double ,delegate: PindergartenViewController) {
        AF.request("\(Constant.BASE_URL)/api/pindergartens?latitude=\(lat)&longitude=\(lon)", method: .get, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: GetAllPindergartenResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if response.isSuccess, let result = response.allpindergartens {
                        delegate.didSuccessGetAllPindergarten(result)
                    }
                    else {
                        delegate.failedToGetAllPindergarten(message: response.message)
                    }
                case .failure(_):
                    delegate.failedToGetAllPindergarten(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
