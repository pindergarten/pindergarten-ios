//
//  GetUserPetsResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/12/05.
//

import Foundation

struct GetUserPetsResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var pets: [GetUserPetResult]?
}

struct GetUserPetResult: Decodable {
    var id: Int
    var userId: Int
    var name: String
    var profileImage: String
    var gender: Int
    var breed: String
    var birth: String
    var vaccination: Int
    var neutering: Int

    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case name
        case profileImage = "profile_image"
        case gender
        case breed
        case birth
        case vaccination
        case neutering
  
    }
}
