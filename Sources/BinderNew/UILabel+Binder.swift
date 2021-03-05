//
//  File.swift
//  
//
//  Created by lihao10 on 2021/3/4.
//
import UIKit

extension UILabel {
    public func bindTitle() -> Binder<String> {
        Binder(target: self) {
            $0.text = $1
        }
    }
}
