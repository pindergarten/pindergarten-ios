//
//  JwtToken.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/24.
//

import Foundation

class JwtToken {
    
    static var token: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjQsImlhdCI6MTYzNzIzNDk4MiwiZXhwIjoxNjY4NzcwOTgyLCJzdWIiOiJ1c2VySW5mbyJ9.6ybAOR9uLZ3I9FGKX3Pp_PZsadu5CaMtrcaZ6m5-74c"
//    static var token: String = UserDefaults.standard.string(forKey: "token") ?? ""
    
//    static var token: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjIsImlhdCI6MTYzNTkyNDY3NywiZXhwIjoxNjY3NDYwNjc3LCJzdWIiOiJ1c2VySW5mbyJ9._R0mcIgahf8a0L7GlOP1FIUpXn5t-dsQa812UpKbNtw"
    static var userId: Int = UserDefaults.standard.integer(forKey: "userId")
    
}
