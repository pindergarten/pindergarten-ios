//
//  GetMyProfileResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/12/05.
//

import Foundation

struct GetMyProfileResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var user: GetUserResult?
}

