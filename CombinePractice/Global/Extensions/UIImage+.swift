//
//  UIImage+.swift
//  assignment
//
//  Created by 김나연 on 4/27/24.
//

import UIKit

extension UIImage {
    
    static func load(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = name
        return image
    }
}
