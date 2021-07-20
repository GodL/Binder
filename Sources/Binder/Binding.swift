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
    
    private var flows: [AnyFlow] = []
    
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
    
    func subscribe(_ flow: AnyFlow) {
        flows.append(flow)
    }
    
    private func consume() {
        self.consumers.forEach { $0.consume(with: self._value) }
    }
    
    private func flow() {
        flows.forEach { $0.flow(with: _value) }
    }
    
    func asBinding() -> Binding<Value> {
        self
    }
}

extension Binding {
    
    @discardableResult
    public static func ~><Consumer: Consumable>(lhs: Binding<Value>, consumer: Consumer) -> Disposable where Consumer.Value == Value {
        let index = lhs.consumers.count
        let anyConsumer = AnyConsumer(consumer)
        let dispose = AnyDispose {
            let nonConsumer = AnyConsumer(NonConsumer<Consumer.Value>())
            lhs.consumers.replaceSubrange(index..<index + 1, with: [nonConsumer])
        }
        lhs.bind(anyConsumer)
        return dispose
    }
}
