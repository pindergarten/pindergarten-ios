////
////  GetAllPindergartenDataManager.swift
////  pindergarten
////
////  Created by MIN SEONG KIM on 2021/11/14.
////
//
//import Alamofire
//
//class GetAllPindergartenDataManager {
//    func getLikePindergarten(delegate: PindergartenViewController) {
//        AF.request("\(Constant.BASE_URL)/api/pindergartens", method: .get, headers: Constant.HEADERS)
//            .validate()
//            .responseDecodable(of: GetAllPindergartenResponse.self) { response in
//                switch response.result {
//                case .success(let response):
//                    // 성공했을 때
//                    if response.isSuccess, let result = response.allpindergartens {
//                        delegate.didSuccessGetAllPindergarten(result)
//                    }
//                    // 실패했을 때
//                    else {
//                        switch response.code {
//                        default: delegate.failedToGetAllPindergarten(message: "이벤트 불러오기에 실패하였습니다")
//                        }
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    delegate.failedToGetAllPindergarten(message: "서버와의 연결이 원활하지 않습니다")
//                }
//            }
//    }
//}