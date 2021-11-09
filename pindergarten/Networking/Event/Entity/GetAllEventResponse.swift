//
//  GetAllEventResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/09.
//

import Foundation

struct GetAllEventResponse: Decodable {
        var isSuccess: Bool
        var code: Int
        var message: String
        var allevents: [GetAllEventResult]?
}

struct GetAllEventResult: Decodable {
    var id: Int
    var title: String
    var thumbnail: String
    var expiredAt: String
    var createdAt: String

    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnail
        case expiredAt = "expired_at"
        case createdAt = "created_at"
    }
}

