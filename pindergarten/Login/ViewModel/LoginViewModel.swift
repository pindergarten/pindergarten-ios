//
//  LoginViewModel.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2022/04/28.
//

import Foundation
import RxSwift
import RxRelay

class LoginViewModel {
    private let disposeBag = DisposeBag()
    
    let phoneNumberTextObserver = BehaviorRelay<String>(value: "")
    let passwordTextObserver = BehaviorRelay<String>(value: "")
    
    var isValid: Observable<Bool> {
        return Observable.combineLatest(phoneNumberTextObserver.asObservable(), passwordTextObserver.asObservable())
            .map { phoneNumber, password in
                let phoneNumberPattern = "^[0-9]{11}$"
                let regex = try? NSRegularExpression(pattern: phoneNumberPattern)
                
                if let _ = regex?.firstMatch(in: phoneNumber, options: [], range: NSRange(location: 0, length: phoneNumber.count)) {
                    return password.count >= 8 && password.count <= 16
                }
                return false
            }
    }
}
