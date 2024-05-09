//
//  LoginViewController.swift
//  assignment
//
//  Created by 김나연 on 4/16/24.
//

import UIKit

import SnapKit

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
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
        
        setDelegate()
        setButtonAction()
    }
}

// MARK: - Extensions

private extension LoginViewController {
    
    func setDelegate() {
        idTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func setButtonAction() {
        loginButton.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        goToCreateNicknameButton.addTarget(self, action: #selector(goToCreateNicknameButtonDidTap), for: .touchUpInside)
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
            welcomeVC.nickname = nickname
            self.navigationController?.pushViewController(welcomeVC, animated: true)
        }
    }
    
    @objc func goToCreateNicknameButtonDidTap() {
//        let createNicknameVC = CreateNicknameViewController()
//        createNicknameVC.delegate = self
//        createNicknameVC.modalPresentationStyle = .pageSheet
//        self.present(createNicknameVC, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.makeBorder(width: 1, color: .gray2)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.makeBorder(width: 0, color: .clear)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if !idTextField.isEmpty, !passwordTextField.isEmpty {
            changeLoginButtonActivationState(to: true)
        } else {
            changeLoginButtonActivationState(to: false)
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
