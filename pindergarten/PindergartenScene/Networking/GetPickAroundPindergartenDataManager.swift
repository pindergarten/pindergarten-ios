//
//  GetPickAroundPindergartenDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/16.
//

import Alamofire

class GetPickAroundPindergartenDataManager {
    func getPickAroundPindergarten(lat: Double, lon: Double ,delegate: PindergartenViewController) {
        AF.request("\(Constant.BASE_URL)/api/near/pindergartens?latitude=\(lat)&longitude=\(lon)", method: .get, headers: Constant.AROUNDHEADERS)
            .validate()
            .responseDecodable(of: GetPickAroundPindergartenResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if response.isSuccess, let result = response.nearPindergartens {
                        delegate.didSuccessGetNearPindergarten(result)
                    }
                    else {
                        delegate.failedToGetNearPindergarten(message: response.message)
                    }
                case .failure(_):
                    delegate.failedToGetNearPindergarten(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
