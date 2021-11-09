//
//  EventLikeDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/09.
//

import Alamofire

class EventLikeDataManager {
    
    func likeEvent(eventId: Int, delegate: DetailEventController) {
        AF.request("\(Constant.BASE_URL)/api/events/\(eventId)/like", method: .post,headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: EventLikeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didSuccessLikeEvent(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToLikeEvent(message: "이벤트 좋아요에 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToLikeEvent(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
