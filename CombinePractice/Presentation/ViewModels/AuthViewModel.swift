//
//  AuthViewModel.swift
//  CombinePractice
//
//  Created by 김나연 on 5/10/24.
//

import UIKit
import Combine
import CombineCocoa

protocol AuthViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(from input: Input) -> Output
}

enum AuthTextFieldType {
    case id
    case pw
}

final class AuthViewModel: AuthViewModelType {
    
    var cancelBag = CancelBag()
    
    struct Input {
        let idTextFieldPublisher: AnyPublisher<Bool, Never>
        let pwTextFieldPublisher: AnyPublisher<Bool, Never>
        let idTextFieldFocus: AnyPublisher<AuthTextFieldType, Never>
        let pwTextFieldFocus: AnyPublisher<AuthTextFieldType, Never>
    }
    
    struct Output {
        let isAllEntered: AnyPublisher<Bool, Never>
        let textFieldFocus: AnyPublisher<AuthTextFieldType, Never>
    }
    
    func transform(from input: Input) -> Output {
        let isAllEnteredPublisher = Publishers.CombineLatest(
            input.idTextFieldPublisher,
            input.pwTextFieldPublisher
        )
            .print()
            .map { $0 && $1 }
            .eraseToAnyPublisher()
        
        let textFieldFocusPublisher = Publishers.Merge(
            input.idTextFieldFocus,
            input.pwTextFieldFocus
        )
            .print()
            .eraseToAnyPublisher()
        
        return Output(isAllEntered: isAllEnteredPublisher, textFieldFocus: textFieldFocusPublisher)
    }
}

class CancelBag {
    var subscriptions = Set<AnyCancellable>()
    
    func cancel() {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
    
    init() { }
}

extension AnyCancellable {
    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
