//
//  DeleteMyPetResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/24.
//

import Foundation

struct DeleteMyPetResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
