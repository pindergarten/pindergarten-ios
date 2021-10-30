//
//  RegisterUserResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/30.
//

import Foundation

struct RegisterUserResponse: Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result: RegisterUserResult?
}

struct RegisterUserResult: Decodable {
    var userId : Int
}
