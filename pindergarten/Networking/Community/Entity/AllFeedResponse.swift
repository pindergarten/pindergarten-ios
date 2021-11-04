//
//  AllFeedResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/03.
//

import Foundation

struct AllFeedResponse: Decodable {
        var isSuccess: Bool
        var code: Int
        var message: String
        var allposts: [GetAllFeedResult]?
}

struct GetAllFeedResult: Decodable {
    var id: Int
    var content: String
    var thumbnail: String
    var nickname: String
    var profileimg: String
    var isLiked: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case content
        case thumbnail
        case nickname
        case profileimg = "profile_img"
        case isLiked
    }
}


