//  A type-erased Consumable value
//
//  AnyConsumer.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/8.
//

public struct AnyConsumer<Value>: Consumable {
    
    var _handler: ((Value) -> Void)?
    
    public init<Consumer: Consumable>(_ consumer: Consumer) where Value == Consumer.Value {
        _handler = {
            consumer.consume(with: $0)
        }
    }
    
    public func consume(with value: Value) {
        _handler?(value)
    }
}

struct NonConsumer<Value>: Consumable {
    public func consume(with value: Value) {}
}
