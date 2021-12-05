//
//  GetUserPostsResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/12/05.
//

import Foundation

struct GetUserPostsResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
   
    var posts: [GetUserPostResult]?
}


struct GetUserPostResult: Decodable {
    var id: Int
    var userId: Int
    var thumbnail: String
}
