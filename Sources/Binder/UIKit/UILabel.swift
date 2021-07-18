//
//  UILabel.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/9.
//

import UIKit

extension Bind where Base : UILabel {
    
    public var text: Binder<String> {
        Binder(target: self.base) {
            $0.text = $1
        }
    }
    
    public var arrtibutedText: Binder<NSAttributedString> {
        Binder(target: self.base) {
            $0.attributedText = $1
        }
    }
    
    public var textColor: Binder<UIColor?> {
        Binder(target: self.base) {
            $0.textColor = $1
        }
    }
    
}
