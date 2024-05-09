//
//  String+.swift
//  assignment
//
//  Created by 김나연 on 4/19/24.
//

import UIKit

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let passwordRegEx = "[A-Za-z0-9!_@$%^&+=]{8,20}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func getLabelContentSize(withFont font: UIFont) -> CGSize {
        let label = UILabel()
        label.font = font
        label.text = self
        return label.intrinsicContentSize
    }
}
