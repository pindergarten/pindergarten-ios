//
//  SendAuthNumberResponse.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/30.
//

import Foundation

struct SendAuthNumberResponse: Decodable {
    
    var isSuccess: Bool
    var code: Int
    var message: String
    
}
