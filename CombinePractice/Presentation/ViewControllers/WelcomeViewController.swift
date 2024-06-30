//
//  WelcomeViewController.swift
//  assignment
//
//  Created by 김나연 on 4/19/24.
//

import UIKit

import SnapKit

final class WelcomeViewController: UIViewController {
    
    // MARK: - Properties
    
    var nickname: String = ""
    
    // MARK: - UI Components
    
    private lazy var rootView = WelcomeView(nickname: nickname)
    private lazy var goMainButton = rootView.goMainButton
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setButtonAction()
    }
}

// MARK: - Extensions

private extension WelcomeViewController {
    
    func setNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setButtonAction() {
        goMainButton.addTarget(self, action: #selector(goMainButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc
    func goMainButtonDidTap() {
        let vc = ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
