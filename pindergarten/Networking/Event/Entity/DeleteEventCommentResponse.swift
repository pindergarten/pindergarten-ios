//
//  DeleteEventCommentResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/10.
//

import Foundation

struct DeleteEventCommentResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
