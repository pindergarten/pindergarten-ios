//
//  GetAllMyPetsResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/23.
//

import Foundation

struct GetAllMyPetsResponse: Decodable {
        var isSuccess: Bool
        var code: Int
        var message: String
        var pets: [GetAllMyPetsResult]?
}

struct GetAllMyPetsResult: Decodable {
    var id: Int
    var name: String
    var profileImage: String

    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profileImage = "profile_image"
  
    }
}
