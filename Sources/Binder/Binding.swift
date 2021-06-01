//
//  Binding.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/8.
//

@propertyWrapper
public class Binding<Value>: Producable {
    private var _value: Value
    
    private var consumers: [AnyConsumer<Value>] = []
    
    var flows: [AnyFlow] = []
    
    public var wrappedValue: Value {
        set {
            _value = newValue
            consume()
            flow()
        }
        get {
            _value
        }
    }
    
    public var projectedValue: Binding<Value> { self }
    
    public init(wrappedValue: Value) {
        self._value = wrappedValue
    }
    
    func bind(_ consumer: AnyConsumer<Value>)  {
        self.consumers.append(consumer)
    }
    
    private func consume() {
        self.consumers.forEach { $0.consume(with: self._value) }
    }
    
    private func flow() {
        flows.forEach { $0.flow(with: _value) }
    }
    
    public func asBinding() -> Binding<Value> {
        self
    }
}

extension Binding {
    public static func ~><Consumer: Consumable>(lhs: Binding<Value>, consumer: Consumer) where Consumer.Value == Value {
        lhs.bind(AnyConsumer(consumer))
    }
}
