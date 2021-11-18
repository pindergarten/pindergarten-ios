//
//  GetDetailPindergartenDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/15.
//

import Alamofire

class GetDetailPindergartenDataManager {
    func getDetailPindergarten(pindergartenId: Int, delegate: DetailPindergartenController) {
        AF.request("\(Constant.BASE_URL)/api/pindergartens/\(pindergartenId)", method: .get, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: GetDetailPindergartenResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.pindergarten {
                        delegate.didSuccessGetDetailPindergarten(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToGetDetailPindergarten(message: "유치원 상세조회에 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetDetailPindergarten(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
