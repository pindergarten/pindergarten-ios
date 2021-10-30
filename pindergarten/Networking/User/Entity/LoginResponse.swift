//
//  LoginResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/30.
//

import Foundation

struct LoginResponse: Decodable {
    
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : LoginResult?
    
}

struct LoginResult: Decodable {
    var userId : Int
    var jwt : String
}
