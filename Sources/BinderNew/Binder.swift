//
//  File.swift
//  
//
//  Created by lihao10 on 2021/3/4.
//

public struct Binder<Value>: Consumable {
    
    let _handler: (Value) -> Void
    
    public init<Target>(target: Target, _ handler: @escaping (Target, Value) -> Void) {
        _handler = {
            handler(target, $0)
        }
    }
    
    public func consume(with value: Value) {
        _handler(value)
    }
}
