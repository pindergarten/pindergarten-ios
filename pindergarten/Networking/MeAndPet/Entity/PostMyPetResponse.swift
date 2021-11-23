//
//  PostMyPetResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/23.
//

import Foundation

struct PostMyPetResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: PostMyPetResult?
}

struct PostMyPetResult: Decodable {
    var petId: Int
}
