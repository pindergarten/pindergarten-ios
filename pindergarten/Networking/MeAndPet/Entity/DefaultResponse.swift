//
//  LogoutResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/25.
//

import Foundation

struct DefaultResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
