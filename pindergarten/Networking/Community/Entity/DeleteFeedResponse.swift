//
//  DeleteFeedResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/05.
//

import Foundation

struct DeleteFeedResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
