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
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(Int.self, forKey: .id)
//        thumbnail = try container.decode(String.self, forKey: .thumbnail)
//        content = try container.decode(String.self, forKey: .content)
//        date = try container.decode(String.self, forKey: .date)
//        nickname = try container.decode(String.self, forKey: .nickname)
//        profileimg = try container.decode(String.self, forKey: .profileimg)
//        imgUrls = try container.decode([DetailFeedImage]?.self, forKey: .imgUrls)
//        likeCount = try container.decode(Int.self, forKey: .likeCount)
//        commentCount = try container.decode(Int.self, forKey: .commentCount)
//        
//    }
//    
    var id: Int
    var content: String
    var date: String
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


