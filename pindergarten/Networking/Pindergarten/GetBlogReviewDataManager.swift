//
//  GetBlogReviewDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/15.
//

import Alamofire

class GetBlogReviewDataManager {
    func getBlogReviewPindergarten(pindergartenId: Int ,delegate: DetailPindergartenController) {
        let url = "\(Constant.BASE_URL)/api/pindergartens/\(pindergartenId)/review"
        AF.request(url, method: .get, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: GetBlogReviewResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.blogReviews {
                        delegate.didSuccessGetBlogReviewPindergarten(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToGetBlogReviewPindergarten(message: "블로그 불러오기에 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetBlogReviewPindergarten(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

