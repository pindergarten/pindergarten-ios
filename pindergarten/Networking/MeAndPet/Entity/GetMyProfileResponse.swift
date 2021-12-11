//
//  GetMyProfileResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/12/05.
//

import Foundation

struct GetMyProfileResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var user: GetUserResult?
//    var id: Int
//    var nickname: String
//    var phone: String
//    var profileImage: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case nickname
//        case phone
//        case profileImage = "profile_img"
//    }
}

