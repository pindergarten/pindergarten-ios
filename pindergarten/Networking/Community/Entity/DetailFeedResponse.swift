//
//  DetailFeedResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/03.
//

import Foundation

struct DetailFeedResponse: Decodable {

    var isSuccess: Bool
    var code: Int
    var message: String
    var post: GetDetailFeedResult?
}

struct GetDetailFeedResult: Decodable {

    var id: Int
    var content: String
    var date: String
    var userId: Int
    var nickname: String
    var profileimg: String
    var imgUrls: [DetailFeedImage]?
    var likeCount: Int
    var commentCount: Int
    var isLiked: Int
    
    enum CodingKeys: String,CodingKey {

        case id
        case content
        case date
        case userId
        case nickname
        case profileimg = "profile_img"
        case imgUrls
        case likeCount
        case commentCount
        case isLiked
    }
}


struct DetailFeedImage: Decodable {
    var postImageUrl: String
}


