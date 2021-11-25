//
//  JwtToken.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/24.
//

import Foundation

class JwtToken {
    
 
    static var token: String = UserDefaults.standard.string(forKey: "token") ?? ""
    
    static var userId: Int = UserDefaults.standard.integer(forKey: "userId")
    
}
