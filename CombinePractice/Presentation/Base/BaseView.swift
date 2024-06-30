//
//  BaseView.swift
//  assignment
//
//  Created by 김나연 on 4/16/24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final func setUI() {
        setStyle()
        setHierarchy()
        setLayout()
    }
    
    /// View의 Style을 set 합니다.
    func setStyle() {}
    /// View의 Hierarchy를 set 합니다.
    func setHierarchy() {}
    /// View의 Layout을 set 합니다.
    func setLayout() {}
}
