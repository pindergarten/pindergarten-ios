//
//  GetPickAroundPindergartenResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/11/16.
//

import Foundation

struct GetPickAroundPindergartenResponse: Decodable {
        var isSuccess: Bool
        var code: Int
        var message: String
        var nearPindergartens: [GetAllPindergartenResult]?
}
