//
//  GetEventCommentResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/09.
//

import Foundation

struct GetEventCommentResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var comments: [GetEventCommentResult]?
}

struct GetEventCommentResult: Decodable {
    var id: Int
    var userId: Int
    var nickname: String
    var profileimg: String
    var date: String
    var content: String
    
    
    enum CodingKeys: String,CodingKey {

        case id
        case userId
        case nickname
        case profileimg = "profile_img"
        case date
        case content
    }
    
    static func ==(left: GetEventCommentResult, right: GetEventCommentResult) -> Bool {
        return left.id == right.id
    }
}
