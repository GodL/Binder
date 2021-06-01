//
//  Bind.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/8.
//

public protocol BindCompatible {}

extension BindCompatible {
    public var bind: Bind<Self> {
        Bind(self)
    }
}

public struct Bind<Base> {
    public let base: Base
    
    fileprivate init(_ base: Base) {
        self.base = base
    }
}


import Foundation

extension NSObject: BindCompatible {}
