//
//  PostMyPetRequest.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/23.
//

import Foundation

struct PostMyPetRequest: Encodable {
    var name: String
    var profileImage: Data
    var gender: Int = 2
    var breed: String
    var birth: String
    var vaccination: Int = 2
    var neutering: Int = 2
    
    enum CodingKeys: String,CodingKey {

        case name
        case profileImage = "profile_image"
        case gender
        case breed
        case birth
        case vaccination
        case neutering

    }
}
