//
//  PostFeedDataManager.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/24.
//

import Alamofire

class PostFeedDataManager {

    func postFeed(
        images: [UIImage]?,
        content: String,
        delegate: PostFeedController,
        completion: @escaping (Bool) -> Void
    ) {
        let URL = "\(Constant.BASE_URL)/api/posts"
        let header = Constant.FORMDATAHEADERS
        let parameters: [String : Any] = [
            "content": content,
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
            
            if let imageArray = images {
                 for image in imageArray {
                    if let image = image.jpegData(compressionQuality: 1.0) {
                         multipartFormData.append(image,
                                                  withName: "images",
                                                  fileName: "\(image).jpeg",
                                                  mimeType: "image/jpeg")
                    }
                 }
             }
        }, to: URL, usingThreshold: UInt64.init(), method: .post, headers: header)
        .validate()
        .responseDecodable(of: PostMyPetResponse.self) { response in
            switch response.result {
            case .success(let response):
                // 성공했을 때
                if response.isSuccess {
                    delegate.didSuccessPostFeed()
                }
                // 실패했을 때
                else {
                    switch response.code {
                    default:
                        delegate.failedToPostFeed(message: "게시물 등록에 실패하였습니다")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                delegate.failedToPostFeed(message: "서버와의 연결이 원활하지 않습니다")
            }
        }
    }
}
