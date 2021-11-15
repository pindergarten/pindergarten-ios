//
//  PindergartenLikeRequest.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/14.
//

import Foundation

struct PindergartenLikeResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: PindergartenLikeResult?
}

struct PindergartenLikeResult: Decodable {
    var isSet: Int
}

