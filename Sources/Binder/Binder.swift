//
//  Binder.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/8.
//

public struct Binder<Value>: Consumable {
    let _handler: (Value) -> Void
    
    public init<Target>(target: Target, _ handler: @escaping (Target, Value) -> Void) {
        _handler = {
            handler(target, $0)
        }
    }
    
    public init<Target: AnyObject>(target: Target, keyPath: ReferenceWritableKeyPath<Target, Value>) {
        _handler = {
            target[keyPath: keyPath] = $0
        }
    }
    
    public func consume(with value: Value) {
        _handler(value)
    }
}
