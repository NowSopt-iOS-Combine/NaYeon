//
//  LoginViewController.swift
//  assignment
//
//  Created by 김나연 on 4/16/24.
//

import UIKit

import Combine
import CombineCocoa
import SnapKit

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel = AuthViewModel()
    private var cancelBag = CancelBag()
    private var nickname = ""
    
    // MARK: - UI Components
    
    private let rootView = LoginView()
    private lazy var loginButton = rootView.loginButton
    private lazy var goToCreateNicknameButton = rootView.goToCreateNicknameButton
    private lazy var idTextField = rootView.idTextField
    private lazy var passwordTextField = rootView.passwordTextField
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        setButtonAction()
    }
    
    func bindViewModel() {
        let idTextFieldFocus = idTextField.didBeginEditingPublisher
            .map { return AuthTextFieldType.id }
            .eraseToAnyPublisher()
        
        let pwTextFieldFocus = passwordTextField.didBeginEditingPublisher
            .map { return AuthTextFieldType.pw }
            .eraseToAnyPublisher()
        
        let idTextFieldPublisher = idTextField.textPublisher
            .map {
                guard let text = $0 else { return false }
                return !text.isEmpty
            }
            .eraseToAnyPublisher()
        
        let pwTextFieldPublisher = passwordTextField.textPublisher
            .map {
                guard let text = $0 else { return false }
                return !text.isEmpty
            }
            .eraseToAnyPublisher()
        
        let input = AuthViewModel.Input(
            idTextFieldPublisher: idTextFieldPublisher,
            pwTextFieldPublisher: pwTextFieldPublisher,
            idTextFieldFocus: idTextFieldFocus,
            pwTextFieldFocus: pwTextFieldFocus
        )
        
        let output = viewModel.transform(from: input)
        
        output.isAllEntered
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] isAllEntered in
                if isAllEntered { self?.changeLoginButtonActivationState(to: true)}
                else { self?.changeLoginButtonActivationState(to: false)}
            })
            .store(in: cancelBag)
        
        output.textFieldFocus
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] textFieldType in
                switch textFieldType {
                case .id:
                    self?.idTextField.makeBorder(width: 1, color: .gray2)
                    self?.passwordTextField.makeBorder(width: 0, color: .clear)
                case .pw:
                    self?.passwordTextField.makeBorder(width: 1, color: .gray2)
                    self?.idTextField.makeBorder(width: 0, color: .clear)
                }
            })
            .store(in: cancelBag)
    }
}

// MARK: - Extensions

private extension LoginViewController {
    
    func setButtonAction() {
        loginButton.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
    }
    
    func changeLoginButtonActivationState(to state: Bool) {
        loginButton.isEnabled = state
        loginButton.backgroundColor = state ? .red : .black
        loginButton.setTitleColor(state ? .white : .gray2, for: .normal)
    }
    
    // MARK: - Actions
    
    @objc
    func loginButtonDidTap() {
        if let id = idTextField.text, let pw = passwordTextField.text {
            guard id.isValidEmail() else {
                return makeAlert(title: "", message: I18N.Auth.emailValidationText)
            }
            guard pw.isValidPassword() else {
                return makeAlert(title: "", message: I18N.Auth.pwValidationText)
            }
            let welcomeVC = WelcomeViewController()
            welcomeVC.nickname = idTextField.text ?? ""
//            welcomeVC.nickname = nickname
            self.navigationController?.pushViewController(welcomeVC, animated: true)
        }
    }
}

extension LoginViewController: DataBindProtocol {
    func dataBind(nickname: String) {
        self.nickname = nickname
    }
}

protocol DataBindProtocol: AnyObject {
    func dataBind(nickname: String)
}
