//
//  UserReportDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/12/13.
//

import Alamofire

class UserReportDataManager {
    
    func reportUser(userId: Int, type: Int, _ parameters: ReportRequest, delegate: UserReportController) {
        AF.request("\(Constant.BASE_URL)/api/users/\(userId)/report?type=\(type)", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: ReportResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessReportUser()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToReportUser(message: response.message)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToReportUser(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
