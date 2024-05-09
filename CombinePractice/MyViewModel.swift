//
//  MyViewModel.swift
//  CombinePractice
//
//  Created by 김나연 on 5/3/24.
//

import Foundation
import Combine

class MyViewModel {
    
    @Published var passwordInput: String = "" {
        didSet {
            print("MyViewModel / passwordInput : \(passwordInput)")
        }
    }
    @Published var passwordConfirmInput: String = "" {
        didSet {
            print("MyViewModel / passwordConfirmInput : \(passwordConfirmInput)")
        }
    }
    
    lazy var isMatchPasswordInput: AnyPublisher<Bool, Never> = Publishers
        .CombineLatest($passwordInput, $passwordConfirmInput)
        .map({ (password: String, passwordConfirm: String) in
            if password == "" || password == "" {
                return false
            }
            if password == passwordConfirm {
                return true
            } else {
                return false
            }
        })
        .print()
        .eraseToAnyPublisher()
}
