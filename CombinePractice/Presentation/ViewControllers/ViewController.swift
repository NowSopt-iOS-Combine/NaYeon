//
//  ViewController.swift
//  CombinePractice
//
//  Created by 김나연 on 5/3/24.
//

import UIKit

import Combine
import SnapKit

class ViewController: UIViewController {

    var viewModel: MyViewModel!
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .gray
        return textField
    }()
    
    let passwordConfirmTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .gray
        return textField
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("버튼", for: .normal)
        return button
    }()
    
    private var mySubscription = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setLayout()
        viewModel = MyViewModel()
        
        passwordTextField
            .myTextPublisher
//            .print()
            .receive(on: DispatchQueue.main)
            .assign(to: \.passwordInput, on: viewModel)
            .store(in: &mySubscription)
        
        passwordConfirmTextField
            .myTextPublisher
//            .print()
            .receive(on: DispatchQueue.main)
            .assign(to: \.passwordConfirmInput, on: viewModel)
            .store(in: &mySubscription)
        
        // 버튼이 뷰모델 퍼블리셔 구독
        viewModel.isMatchPasswordInput
            .print()
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: button)
            .store(in: &mySubscription)
    }

    
}

extension ViewController {
    func setLayout() {
        [passwordTextField, passwordConfirmTextField, button].forEach {
            self.view.addSubview($0)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }
        
        passwordConfirmTextField.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }
        
        button.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(passwordConfirmTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }
    }
}

extension UITextField {
    var myTextPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
//            .print()
            .compactMap { $0.object as? UITextField }
            .map { $0.text ?? "" }
            .print()
            .eraseToAnyPublisher()
    }
}

extension UIButton {
    var isValid: Bool {
        get {
            backgroundColor == .yellow
        }
        set {
            backgroundColor = newValue ? .yellow : .lightGray
            isEnabled = newValue
            setTitleColor(newValue ? .blue : .white, for: .normal)
        }
    }
}
