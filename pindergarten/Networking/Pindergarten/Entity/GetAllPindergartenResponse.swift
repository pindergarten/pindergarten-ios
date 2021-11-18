//
//  GetAllPindergartenResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/14.
//

import Foundation

struct GetAllPindergartenResponse: Decodable {
        var isSuccess: Bool
        var code: Int
        var message: String
        var allpindergartens: [GetAllPindergartenResult]?
}

struct GetAllPindergartenResult: Decodable {
    var id: Int
    var name: String
    var address: String
    var thumbnail: String
    var latitude: String? = ""
    var longitude: String? = ""
    var rating: Double
    var distance: Double?
    var isLiked: Int
}
