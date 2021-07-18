//
//  UITextField.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/7/18.
//

import UIKit.UITextField

extension Bind where Base : UITextField {
    
    public var text: Binder<String> {
        Binder(target: self.base) {
            $0.text = $1
        }
    }
    
    public var attributedText: Binder<NSAttributedString?> {
        Binder(target: self.base) {
            $0.attributedText = $1
        }
    }
}
