//
//  GetBlockUserResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/12/13.
//

import Foundation

struct GetBlockUserResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var blockList: [GetBlockUserResult]?
}

struct GetBlockUserResult: Decodable {
    var blockUserId: Int
    var nickname: String
    var profileimg: String
    var date: String
    
    
    enum CodingKeys: String, CodingKey {
        case blockUserId
        case nickname
        case profileimg = "profile_img"
        case date
    }
}

