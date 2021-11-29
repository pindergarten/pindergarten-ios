//
//  GetLikePindergartenResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/14.
//

import Foundation

struct GetLikePindergartenResponse: Decodable {
        var isSuccess: Bool
        var code: Int
        var message: String
        var likedPindergartens: [GetLikePindergartenResult]?
}

struct GetLikePindergartenResult: Decodable {
    var id: Int
    var name: String
    var address: String
    var thumbnail: String
    var rating: Double
    var distance: Double
    var isLiked: Int? = 1
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case thumbnail
        case rating
        case distance
        case isLiked
    }


}


