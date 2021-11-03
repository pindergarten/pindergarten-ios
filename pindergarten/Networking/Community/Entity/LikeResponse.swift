//
//  LikeResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/04.
//

import Foundation

struct LikeResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: LikeResult?
}

struct LikeResult: Decodable {
    var isSet: Int
}
