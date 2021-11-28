//
//  JwtToken.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/24.
//

import Foundation

class JwtToken {

    static var token: String = UserDefaults.standard.string(forKey: "token") ?? "" {
        didSet {
            Constant.HEADERS = ["x-access-token" : token]
            Constant.FORMDATAHEADERS = ["x-access-token" : token, "Content-Type" : "multipart/form-data"]
        }
    }
    
    static var userId: Int = UserDefaults.standard.integer(forKey: "userId")
    
}
