//
//  CheckAuthNumberResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/30.
//

import Foundation

struct CheckAuthNumberResponse: Decodable {
    
    var isSuccess: Bool
    var code: Int
    var message: String
    
}
