//
//  UIButton+.swift
//  assignment
//
//  Created by 김나연 on 4/19/24.
//

import UIKit

extension UIButton {
    
    func underlineTitle() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(attributedString, for: .normal)
    }
}
