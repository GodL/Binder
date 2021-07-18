//
//  UIImageView.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/10.
//

import UIKit.UIImageView

extension Bind where Base : UIImageView {
    public var image: Binder<UIImage?> {
        Binder(target: self.base) {
            $0.image = $1
        }
    }
    
    public var highlightedImage: Binder<UIImage?> {
        Binder(target: self.base) {
            $0.highlightedImage = $1
        }
    }
}
