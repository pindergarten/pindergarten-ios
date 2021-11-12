//
//  ReportDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/10.
//

import Alamofire

class ReportDataManager {
    
    func reportFeed(postId: Int, type: Int, _ parameters: ReportRequest, delegate: ReportController) {
        AF.request("\(Constant.BASE_URL)/api/posts/\(postId)/declaration?type=\(type)", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: ReportResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessReportFeed()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToReportFeed(message: "신고하기에 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToReportFeed(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
