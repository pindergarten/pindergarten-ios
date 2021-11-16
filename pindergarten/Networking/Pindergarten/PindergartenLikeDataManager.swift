//
//  PindergartenLikeDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/14.
//

import Alamofire

class PindergartenLikeDataManager {

    func likePindergarten(pindergartenId: Int, delegate: LikePindergartenController) {
        AF.request("\(Constant.BASE_URL)/api/pindergartens/\(pindergartenId)/like", method: .post,headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: PindergartenLikeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didSuccessLikePindergarten(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToLikePindergarten(message: "유치원 좋아요에 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToLikePindergarten(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func likePindergarten(pindergartenId: Int, delegate: ContentViewController) {
        AF.request("\(Constant.BASE_URL)/api/pindergartens/\(pindergartenId)/like", method: .post,headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: PindergartenLikeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didSuccessLikePindergarten(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToLikePindergarten(message: "유치원 좋아요에 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToLikePindergarten(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func likePindergarten(pindergartenId: Int, delegate: DetailPindergartenController) {
        AF.request("\(Constant.BASE_URL)/api/pindergartens/\(pindergartenId)/like", method: .post,headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: PindergartenLikeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didSuccessLikePindergarten(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToLikePindergarten(message: "유치원 좋아요에 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToLikePindergarten(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

