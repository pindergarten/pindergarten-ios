//
//  CheckAuthNumberRequest.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2021/10/30.
//

import Foundation

struct CheckAuthNumberRequest: Encodable {
    var phone : String
    var verifyCode : String
}
