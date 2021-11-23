//
//  PostFeedResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/24.
//

import Foundation

struct PostFeedResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
