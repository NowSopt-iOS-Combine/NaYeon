//
//  UIStackView+.swift
//  assignment
//
//  Created by 김나연 on 4/19/24.
//

import UIKit

extension UIStackView {
    
     func addArrangedSubviews(_ views: UIView...) {
         for view in views {
             self.addArrangedSubview(view)
         }
     }
}
