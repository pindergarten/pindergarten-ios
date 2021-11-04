//
//  GetCommentResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/04.
//

import Foundation

struct GetCommentResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [GetCommentResult]?
}

struct GetCommentResult: Decodable {
    var id: Int
    var nickname: String
    var profileimg: String
    var date: String
    var content: String
    
    
    enum CodingKeys: String,CodingKey {

        case id
        case nickname
        case profileimg = "profile_img"
        case date
        case content

    }
}
