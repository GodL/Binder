//
//  File.swift
//  
//
//  Created by lihao10 on 2021/3/4.
//

public protocol Consumable {
    associatedtype Value
    
    func consume(with value: Value)
}

public struct AnyConsumer<Value>: Consumable {
    
    let _consume: (Value) -> Void
    
    public init<Consumer: Consumable>(_ consumer: Consumer) where Consumer.Value == Value {
        _consume = {
            consumer.consume(with: $0)
        }
    }
    
    public func consume(with value: Value) {
        _consume(value)
    }
}
