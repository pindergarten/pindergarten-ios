//
//  GetBlogReviewResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/15.
//

import Foundation

struct GetBlogReviewResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var blogReviews: [GetBlogReviewResult]?
}

struct GetBlogReviewResult: Decodable {
    var title: String? = ""
    var content: String? = ""
    var date: String? = ""
    var link: String? = ""
}
