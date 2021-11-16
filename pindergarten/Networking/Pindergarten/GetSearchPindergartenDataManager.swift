//
//  GetSearchPindergartenDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/16.
//

import Alamofire

class GetSearchPindergartenDataManager {

    func getSearchPindergarten(query: String, lat: Double, lon: Double, delegate: SearchPindergartenController) {
        let urlString = "\(Constant.BASE_URL)/api/serch/pindergartens?query=\(query)&latitude=\(lat)&longitude=\(lon)"
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(encodedString)
        
        AF.request(encodedString, method: .get, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: GetSearchPindergartenResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.searchPindergartens {
                        delegate.didSuccessGetSearchPindergarten(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToGetSearchPindergarten(message: "유치원 검색에 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetSearchPindergarten(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

