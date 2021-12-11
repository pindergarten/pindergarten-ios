//
//  GetMyPageResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/24.
//

import Foundation

struct GetMyPageResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var user: GetUserResult?
    var posts: [GetPostResult]?
}

struct GetUserResult: Decodable {
    var id: Int
    var nickname: String
    var phone: String
    var profileImage: String

    enum CodingKeys: String, CodingKey {
        case id
        case nickname
        case phone
        case profileImage = "profile_img"
    }
}

struct GetPostResult: Decodable {
    var id: Int
    var thumbnail: String
}
