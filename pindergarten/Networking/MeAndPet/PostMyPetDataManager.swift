//
//  PostMyPetDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/23.
//

import Alamofire

class PostMyPetDataManager {

    func registerPet(
        name: String,
        profileImage: UIImage?,
        gender: Int,
        breed: String,
        birth: String,
        vaccination: Int,
        neutering: Int,
        delegate: PetRegisterController,
        completion: @escaping (Bool) -> Void
    ) {
        let URL = "\(Constant.BASE_URL)/api/pets"
        let header = Constant.FORMDATAHEADERS
        let parameters: [String : Any] = [
            "name": name,
            "gender": gender,
            "breed": breed,
            "birth": birth,
            "vaccination": vaccination,
            "neutering": neutering
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
            if let image = profileImage?.jpegData(compressionQuality: 1) {
                multipartFormData.append(image, withName: "profile_image", fileName: "\(image).jpeg", mimeType: "image/jpeg")
            }
        }, to: URL, usingThreshold: UInt64.init(), method: .post, headers: header)
        .validate()
        .responseDecodable(of: PostMyPetResponse.self) { response in
            switch response.result {
            case .success(let response):
                // 성공했을 때
                if response.isSuccess {
                    delegate.didSuccessRegisterPet()
                }
                // 실패했을 때
                else {
                    switch response.code {
                    default:
                        delegate.failedToRegisterPet(message: "나의 펫 등록에 실패하였습니다")
                    print("나의 펫 등록에 실패하였습니다")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                delegate.failedToRegisterPet(message: "서버와의 연결이 원활하지 않습니다")
            }
        }
    }
}


