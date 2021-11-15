//
//  GetBlogReviewResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/15.
//

import Foundation

struct GetBlogReviewResponse: Decodable {
    var lastBuildDate: String
    var total: Int
    var start: Int
    var display: Int
    var items: [GetBlogReviewResult]?
}

struct GetBlogReviewResult: Decodable {
    var title: String
    var link: String
    var description: String
    var bloggername: String
    var bloggerlink: String
    var postdate: String
}
