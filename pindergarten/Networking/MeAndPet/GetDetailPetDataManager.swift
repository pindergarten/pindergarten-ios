////
////  GetDetailPetDataManager.swift
////  pindergarten
////
////  Created by MIN SEONG KIM on 2021/11/24.
////
//
//import Alamofire
//
//class GetDetailPetDataManager {
//    func getDetailPet(petId: Int, delegate: MeAndPetViewController) {
//        AF.request("\(Constant.BASE_URL)/api/pets/\(petId)", method: .get, headers: Constant.HEADERS)
//            .validate()
//            .responseDecodable(of: GetDetailPetResponse.self) { response in
//                switch response.result {
//                case .success(let response):
//                    // 성공했을 때
//                    if response.isSuccess, let result = response.pet {
//                        delegate.didSuccessGetDetailPet(result)
//                    }
//                    // 실패했을 때
//                    else {
//                        switch response.code {
//                        default: delegate.failedToGetDetailPet(message: "선택한 반려견의 정보를 불러오기에 실패하였습니다")
//                        }
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    delegate.failedToGetDetailPet(message: "서버와의 연결이 원활하지 않습니다")
//                }
//            }
//    }
//}
