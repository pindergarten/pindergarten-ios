//
//  ChangeProfileImageDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/25.
//

import Alamofire

class ChangeProfileImageDataManager {

    func changeProfile(
        userId: Int,
        profileImage: UIImage?,
        delegate: UserProfileController,
        completion: @escaping (Bool) -> Void
    ) {
        let URL = "\(Constant.BASE_URL)/api/users/\(userId)"
        let header = Constant.FORMDATAHEADERS
   
        
        AF.upload(multipartFormData: { multipartFormData in
           
            if let image = profileImage?.jpegData(compressionQuality: 1) {
                multipartFormData.append(image, withName: "profile_image", fileName: "\(image).jpeg", mimeType: "image/jpeg")
            }
        }, to: URL, usingThreshold: UInt64.init(), method: .post, headers: header)
        .validate()
        .responseDecodable(of: DefaultResponse.self) { response in
            switch response.result {
            case .success(let response):
                // 성공했을 때
                if response.isSuccess {
                    delegate.didSuccessChangeProfile()
                }
                // 실패했을 때
                else {
                    switch response.code {
                    default:
                        delegate.failedToChangeProfile(message: response.message)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                delegate.failedToChangeProfile(message: "서버와의 연결이 원활하지 않습니다")
            }
        }
    }
}
