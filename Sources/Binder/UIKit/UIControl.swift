//
//  UIControl.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/10.
//

import UIKit.UIControl

extension Bind where Base : UIControl {
    public var isEnabled: Binder<Bool> {
        Binder(target: self.base) {
            $0.isEnabled = $1
        }
    }
    
    public var isSelected: Binder<Bool> {
        Binder(target: self.base) {
            $0.isSelected = $1
        }
    }
    
    public var isHighlighted: Binder<Bool> {
        Binder(target: self.base) {
            $0.isHighlighted = $1
        }
    }
}
