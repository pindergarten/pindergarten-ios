//
//  GetAllEventDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/09.
//

import Alamofire

class GetAllEventDataManager {
    func getAllEvent(delegate: EventViewController) {
        AF.request("\(Constant.BASE_URL)/api/events", method: .get, headers: nil)
            .validate()
            .responseDecodable(of: GetAllEventResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.allevents {
                        delegate.didSuccessGetAllEvent(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToGetAllEvent(message: "이벤트 불러오기에 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetAllEvent(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}



