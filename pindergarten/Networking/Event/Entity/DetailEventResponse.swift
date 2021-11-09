//
//  DetailEventResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/09.
//

import Foundation

struct GetDetailEventResponse: Decodable {

    var isSuccess: Bool
    var code: Int
    var message: String
    var event: GetDetailEventResult?
}

struct GetDetailEventResult: Decodable {

    var id: Int
    var title: String
    var thumbnail: String
    var expiredAt: String
    var createdAt: String
    var likeCount: Int
    var commentCount: Int
    var isLiked: Int
    
    enum CodingKeys: String,CodingKey {

        case id
        case title
        case thumbnail
        case expiredAt = "expired_at"
        case createdAt = "created_at"
        case likeCount
        case commentCount
        case isLiked
    }
}


 
