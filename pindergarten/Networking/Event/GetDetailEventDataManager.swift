//
//  GetDetailEventDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/09.
//

import Alamofire

class GetDetailEventDataManager {
    func getADetailEvent(eventId: Int, delegate: DetailEventController) {
        AF.request("\(Constant.BASE_URL)/api/events/\(eventId)", method: .get, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: GetDetailEventResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.event {
                        delegate.didSuccessGetDetailEvent(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToGetDetailEvent(message: "이벤트 정보를 가져오는 데 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetDetailEvent(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
