//
//  RegisterUserRequest.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/30.
//

import Foundation

struct RegisterUserRequest: Encodable {
    var phone : String
    var password : String
    var password_check : String
    var nickname : String
}


