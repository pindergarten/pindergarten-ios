//
//  ViewModel.swift
//  pindergarten
//
//  Created by MIN SEONG KIM on 2022/04/28.
//

import Foundation
import RxSwift

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
