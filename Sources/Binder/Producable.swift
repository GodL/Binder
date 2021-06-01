//
//  Producable.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/8.
//

public protocol Producable {
    associatedtype Value
    
    func asBinding() -> Binding<Value>
}
