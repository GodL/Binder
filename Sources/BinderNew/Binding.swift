//
//  File.swift
//  
//
//  Created by lihao10 on 2021/3/4.
//

@propertyWrapper
public class Binding<Value>: Producable {
    
    private var _value: Value
    
    public var wrappedValue: Value {
        set {
            _value = newValue
            consume(with: _value)
            flow()
        }
        get {
            _value
        }
    }
    
    public var projectedValue: Binding<Value> { self }
    
    var consumers: [AnyConsumer<Value>] = []
    
    var subBindings: [AnyFlow] = []
    
    public init(wrappedValue: Value) {
        self._value = wrappedValue
    }
    
    private func consume(with value: Value) {
        consumers.forEach {
            $0.consume(with: value)
        }
    }

    private func flow() {
        subBindings.forEach { $0.flow(with: _value) }
    }
    
    public func asBinding() -> Binding<Value> {
        self
    }
}

extension Binding {
    static public func ~><Consumer: Consumable>(lhs: Binding<Value>, rhs: Consumer) where Value == Consumer.Value {
        lhs.consumers.append(AnyConsumer(rhs))
    }
}
