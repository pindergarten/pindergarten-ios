//
//  GetDetailPetResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/24.
//

import Foundation

struct GetDetailPetResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var pet: [GetDetailPetResult]?
}

struct GetDetailPetResult: Decodable {
    var id: Int
    var name: String
    var profileImage: String
    var gender: Int
    var breed: String
    var birth: String
    var vaccination: Int
    var neutering: Int

    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profileImage = "profile_image"
        case gender
        case breed
        case birth
        case vaccination
        case neutering
  
    }
}
