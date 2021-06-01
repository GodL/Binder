//
//  UIButton.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/9.
//

import UIKit

extension Bind where Base : UIButton {
    
    public var title: Binder<String?> {
        Binder(target: self.base) {
            $0.setTitle($1, for: .normal)
        }
    }
    
    public func title(for state: UIControl.State) -> Binder<String?> {
        Binder(target: self.base) {
            $0.setTitle($1, for: state)
        }
    }
    
    public var image: Binder<UIImage?> {
        Binder(target: self.base) {
            $0.setImage($1, for: .normal)
        }
    }
    
    public func image(for state: UIControl.State) -> Binder<UIImage?> {
        Binder(target: self.base) {
            $0.setImage($1, for: .normal)
        }
    }
}
