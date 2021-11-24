//
//  AutoLoginDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/25.
//

import Alamofire

class AutoLoginDataManager {
    func autoLogin() {
        AF.request("\(Constant.BASE_URL)/api/users/auto-signin", method: .get, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: DefaultResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                    
                    }
                    // 실패했을 때
                    else {
                
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            }
    }
}
