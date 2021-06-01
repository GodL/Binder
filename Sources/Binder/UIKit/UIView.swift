//
//  UIView.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/10.
//

import UIKit

extension Bind where Base : UIView {
    
    public var alpha: Binder<CGFloat> {
        Binder(target: self.base) {
            $0.alpha = $1
        }
    }
    
    public var isHidden: Binder<Bool> {
        Binder(target: self.base) {
            $0.isHidden = $1
        }
    }
    
    public var isUserInteractionEnabled: Binder<Bool> {
        Binder(target: self.base) {
            $0.isUserInteractionEnabled = $1
        }
    }
    
    public var backgroundColor: Binder<UIColor?> {
        Binder(target: self.base) {
            $0.backgroundColor = $1
        }
    }
}
