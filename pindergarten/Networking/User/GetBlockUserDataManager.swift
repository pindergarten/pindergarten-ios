//
//  GetBlockUserDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/12/13.
//

import Alamofire

class GetBlockUserDataManager {
    func getBlockUser(delegate: BlockUserController) {
        AF.request("\(Constant.BASE_URL)/api/block", method: .get, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: GetBlockUserResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.blockList {
                        delegate.didSuccessGetBlockUser(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToGetBlockUser(message: "이벤트 불러오기에 실패하였습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToGetBlockUser(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}

