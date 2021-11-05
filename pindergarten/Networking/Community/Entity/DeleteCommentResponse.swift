//
//  DeleteCommentResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/06.
//

import Foundation

struct DeleteCommentResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
