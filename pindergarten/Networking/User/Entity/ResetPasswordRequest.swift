//
//  ResetPasswordRequest.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/30.
//

import Foundation

struct ResetPasswordRequest: Encodable {
    var phone : String
    var password : String
    var password_check : String
}

