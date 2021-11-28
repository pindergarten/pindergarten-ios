//
//  GetPickAroundPindergartenDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/16.
//

import Alamofire

class GetPickAroundPindergartenDataManager {
//    func getPickAroundPindergarten(lat: Double, lon: Double ,delegate: ContentViewController) {
//        AF.request("\(Constant.BASE_URL)/api/near/pindergartens?latitude=\(lat)&longitude=\(lon)", method: .get, headers: Constant.HEADERS)
//            .validate()
//            .responseDecodable(of: GetPickAroundPindergartenResponse.self) { response in
//                switch response.result {
//                case .success(let response):
//                    // 성공했을 때
//                    if response.isSuccess, let result = response.nearPindergartens {
//                        delegate.didSuccessGetNearPindergarten(result)
//                    }
//                    // 실패했을 때
//                    else {
//                        switch response.code {
//                        default: delegate.failedToGetNearPindergarten(message: "유치원 불러오기에 실패하였습니다")
//                        }
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    delegate.failedToGetNearPindergarten(message: "서버와의 연결이 원활하지 않습니다")
//                }
//            }
//    }
    
    func getPickAroundPindergarten(lat: Double, lon: Double ,delegate: PindergartenViewController) {
        AF.request("\(Constant.BASE_URL)/api/near/pindergartens?latitude=\(lat)&longitude=\(lon)", method: .get, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: GetPickAroundPindergartenResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.nearPindergartens {
                        delegate.didSuccessGetNearPindergarten(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToGetNearPindergarten(message: "유치원 불러오기에 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetNearPindergarten(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
