//
//  GetSearchPindergartenResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/16.
//

import Foundation

struct GetSearchPindergartenResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var searchPindergartens: [GetSearchPindergartenResult]?
}

struct GetSearchPindergartenResult: Decodable {
    var id: Int
    var name: String
    var address: String
    var thumbnail: String
    var latitude: String
    var longitude: String
    var openingHours: String
//    var accessGuide: String
    var rating: String
    var website: String
    var social: String
    var phone: String
    var distance: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case thumbnail
        case latitude
        case longitude
        case openingHours = "opening_hours"
//        case accessGuide = "access_guide"
        case rating
        case website
        case social
        case phone
        case distance
    }
}

