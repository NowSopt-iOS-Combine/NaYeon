//
//  CustomTextField.swift
//  assignment
//
//  Created by 김나연 on 4/20/24.
//

import UIKit

import SnapKit

final class CustomTextField: UITextField {
    
    // MARK: - UI Components
    
    private let clearButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        button.setImage(.iconXCircle, for: .normal)
        button.isHidden = true
        return button
    }()
    
    private let eyeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        button.setImage(.iconEye, for: .normal)
        button.isHidden = true
        return button
    }()
    
    // MARK: - Properties
    
    var isClearButtonIncluded: Bool {
        get { !clearButton.isHidden }
        set { clearButton.isHidden = !newValue }
    }
    
    var isEyeButtonIncluded: Bool {
        get { !eyeButton.isHidden }
        set { eyeButton.isHidden = !newValue }
    }
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension CustomTextField {
    
    func setStyle() {
        backgroundColor = .gray4
        textColor = .gray2
        font = .font(ofSize: 15, weight: .w600)
        setLeftPadding(amount: 22)
        layer.cornerRadius = 3
    }
    
    func setButtonAction() {
        clearButton.addTarget(self, action: #selector(clearButtonDidTap), for: .touchUpInside)
        eyeButton.addTarget(self, action: #selector(eyeButtonDidTap), for: .touchUpInside)
    }
    
    func setTextFieldRightView() {
        let buttons = [(clearButton, isClearButtonIncluded), (eyeButton, isEyeButtonIncluded)]
            .compactMap {
                if $0.1 { return $0.0 }
                else { return nil }
            }
        if buttons.count < 1 { return }
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.frame = CGRect(x: 0, y: 0, width: (buttons.count == 1) ? 20 : 56, height: 52)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)
        
        rightView = stackView
        rightViewMode = .whileEditing
    }
    
    // MARK: - Actions
    
    @objc
    func clearButtonDidTap(_ sender: UIButton) {
        text = ""
    }
    
    @objc
    func eyeButtonDidTap(_ sender: UIButton) {
        isSecureTextEntry.toggle()
        sender.setImage(self.isSecureTextEntry ? .iconEye : .iconEyeSlash, for: .normal)
    }
}
