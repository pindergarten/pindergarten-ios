//
//  DeleteMyPetDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/24.
//

import Alamofire

class DeleteMyPetDataManager {

    func deleteMyPet(petId: Int, delegate: DetailPetController) {
        AF.request("\(Constant.BASE_URL)/api/pets/\(petId)", method: .delete, headers: Constant.HEADERS)
            .validate()
            .responseDecodable(of: DeleteMyPetResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessDeleteMyPet()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        default: delegate.failedToDeleteMyPet(message: "게시글 삭제에 실패하셨습니다")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToDeleteMyPet(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
