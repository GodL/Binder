//
//  State.swift
//  Binder
//
//  Created by GodL on 2021/2/24.
//

@propertyWrapper
public class State<Value> {
            
    public var _value: Value
    
    public var wrappedValue: Value {
        set {
            _value = newValue
            bind()
            drive()
        }
        get {
            _value
        }
    }
    
    var binders: [AnyBinder<Value>] = []
    
    var drivers: [AnyDriver] = []
    
    public var projectedValue: State<Value> {
        self
    }
    
    public init(wrappedValue: Value) {
        self._value = wrappedValue
        self.wrappedValue = wrappedValue
    }
    
    private func bind() {
        for binder  in binders {
            bind(to: binder)
        }
    }
    
    private func bind<Binder: Bindable>(to binder: Binder) where Binder.Value == Value {
        binder.bind(with: self.wrappedValue)
    }
    
    private func drive() {
        self.drivers.forEach {
            $0.drive(with: self.wrappedValue)
        }
    }
}

infix operator ~>

extension State {
    public static func ~><Binder: Bindable>(lhs: State, rhs: Binder) where Binder.Value == Value {
        lhs.binders.append(AnyBinder(rhs))
    }
}
