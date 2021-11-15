//
//  GetBlogReviewDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/15.
//

import Alamofire

class GetBlogReviewDataManager {
    func getBlogReviewPindergarten(name: String ,delegate: DetailPindergartenController) {
        let urlString = "\(Constant.BASE_URL)/api/blog/search?query=\(name)"
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        AF.request(encodedString, method: .get, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: GetBlogReviewResponse?.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if let result = response {
                        delegate.didSuccessGetBlogReviewPindergarten(result)
                    }
                    // 실패했을 때
                    else {
                       delegate.failedToGetBlogReviewPindergarten(message: "블로그 리뷰 불러오기에 실패하였습니다")
                        }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetBlogReviewPindergarten(message: "서버와의 연결이 원활하지 않습니다")

                }
            }
    }
}

