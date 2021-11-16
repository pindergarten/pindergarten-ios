//
//  GetPickAroundPindergartenResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/16.
//

import Foundation

struct GetPickAroundPindergartenResponse: Decodable {
        var isSuccess: Bool
        var code: Int
        var message: String
        var nearPindergartens: [GetAllPindergartenResult]?
}

//struct GetPickAroundPindergartenResult: Decodable {
//    var id: Int
//    var name: String
//    var address: String
//    var thumbnail: String
//    var latitude: String
//    var longitude: String
//    var rating: Double
//    var distance: Double
//    var isLiked: Int
//}
