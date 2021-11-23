//
//  Constant.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/24.
//

import Alamofire

struct Constant {
    static let BASE_URL = "http://pindergarten.site:3000"
    static var HEADERS: HTTPHeaders = ["x-access-token" : JwtToken.token]
    static var FORMDATAHEADERS: HTTPHeaders = ["x-access-token" : JwtToken.token, "Content-Type" : "multipart/form-data"]
    static let DEFAULT_LAT: Double = 37.540025
    static let DEFAULT_LON: Double = 127.005686
    static let HEIGHT: CGFloat = 812
    static let WIDTH: CGFloat = 375
}
