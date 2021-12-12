//
//  GetEventCommentDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/09.
//


import Alamofire

class GetEventCommentDataManager {
    
    func getEventComment(eventId: Int, delegate: DetailEventController) {
        
        AF.request("\(Constant.BASE_URL)/api/events/\(eventId)/comments", method: .get, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: GetEventCommentResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.comments {
                        
                        delegate.didSuccessGetEventComment(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToGetEventComment(message: "이벤트 댓글을 불러오는데 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetEventComment(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func getEventComment(eventId: Int, delegate: EventCommentController) {
     
        AF.request("\(Constant.BASE_URL)/api/events/\(eventId)/comments", method: .get, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: GetEventCommentResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.comments {
                       
                        delegate.didSuccessGetEventComment(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToGetEventComment(message: "이벤트 댓글을 불러오는데 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetEventComment(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
