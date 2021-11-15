//
//  GetDetailPindergartenResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/15.
//

import Foundation

struct GetDetailPindergartenResponse: Decodable {
        var isSuccess: Bool
        var code: Int
        var message: String
        var event: GetDetailPindergartenResult?
}

struct GetDetailPindergartenResult: Decodable {
    var id: Int
    var name: String
    var address: String
    var thumbnail: String
    var latitude: String
    var longitude: String
    var rating: Double
    var openingHours: String
    var accessGuide: String
    var phone: String
    var website: String
    var social: String
    var createAt: String
    var distance: Double
    var imgUrls: [DetailPindergartenImageUrls]?
    var isLiked: Int
    
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
        case createAt = "created_at"
        case distance
        case imgUrls
        case isLiked
    }
}

struct DetailPindergartenImageUrls: Decodable {
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
    }
}
