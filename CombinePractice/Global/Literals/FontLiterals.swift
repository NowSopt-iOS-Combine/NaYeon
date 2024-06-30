//
//  FontLiterals.swift
//  assignment
//
//  Created by 김나연 on 4/16/24.
//

import Foundation
import UIKit

enum PretendardType: String {
    case thin = "Pretendard-Thin"
    case extraLight = "Pretendard-ExtraLight"
    case light = "Pretendard-Light"
    case regular = "Pretendard-Regular"
    case medium = "Pretendard-Medium"
    case semiBold = "Pretendard-SemiBold"
    case bold = "Pretendard-Bold"
    case extraBold = "Pretendard-ExtraBold"
}

enum FontWeight {
    case w100
    case w200
    case w300
    case w400
    case w500
    case w600
    case w700
    case w800
}

extension FontWeight {
    
    var fontType: String {
        switch self {
        case .w100:
            return PretendardType.thin.rawValue
        case .w200:
            return PretendardType.extraLight.rawValue
        case .w300:
            return PretendardType.light.rawValue
        case .w400:
            return PretendardType.regular.rawValue
        case .w500:
            return PretendardType.medium.rawValue
        case .w600:
            return PretendardType.semiBold.rawValue
        case .w700:
            return PretendardType.bold.rawValue
        case .w800:
            return PretendardType.extraBold.rawValue
        }
    }
}

extension UIFont {
    
    static func font(ofSize size: CGFloat, weight: FontWeight) -> UIFont {
        guard let font = UIFont(name: weight.fontType, size: size)
        else { return UIFont.systemFont(ofSize: size) }
        return font
    }
}
