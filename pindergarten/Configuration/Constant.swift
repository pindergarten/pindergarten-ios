//
//  Constant.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/24.
//

import Alamofire

struct Constant {
    static let BASE_URL = "http://pindergarten.site:3000"
    static var HEADERS: HTTPHeaders = ["" : JwtToken.token]
}
