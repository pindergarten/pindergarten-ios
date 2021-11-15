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
        var result: GetLikePindergartenResult?
}

struct GetLikePindergartenResult: Decodable {
    var pindergartenId: Int
    var pindergarten: [PindergartenResult]?


}

struct PindergartenResult: Decodable {
    var id: Int
    var name: String
    var address: String
    var thumbnail: String
    var latitude: String
    var longitude: String
    var rating: Float
    var openingHours: String
    var accessGuide: String
    var phone: String
    var website: String
    var social: String
    var createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case thumbnail
        case latitude
        case longitude
        case rating
        case openingHours = "opening_hours"
        case accessGuide = "access_guide"
        case phone
        case website
        case social
        case createdAt
    }
}
