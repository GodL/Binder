//
//  KeyPathBinder.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/7/18.
//

extension Bind where Base : AnyObject {
    public subscript<Value>(keyPath: ReferenceWritableKeyPath<Base, Value>) -> Binder<Value> {
        Binder(target: self.base, keyPath: keyPath)
    }
}
