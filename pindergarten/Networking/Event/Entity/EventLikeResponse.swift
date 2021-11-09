//
//  EventLikeResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/09.
//

import Foundation

struct EventLikeResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: EventLikeResult?
}

struct EventLikeResult: Decodable {
    var isSet: Int
}

