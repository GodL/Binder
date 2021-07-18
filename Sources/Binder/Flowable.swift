//
//  Flowable.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/10.
//

protocol Flowable {
    associatedtype Value
    
    func flow(with value: Value)
    
    func subscribe<Producer: Producable>(on producer: Producer) where Producer.Value == Value
}

extension Flowable {
    func subscribe<Producer: Producable>(on producer: Producer) where Producer.Value == Value {
        producer.asBinding().subscribe(AnyFlow(self))
    }

}

/// A type-erased Flowable value
struct AnyFlow: Flowable {
    
    let _handler: (Any) -> Void
    
    public init<Flow: Flowable>(_ flow: Flow) {
        _handler = {
            guard let value = $0 as? Flow.Value else { fatalError() }
            flow.flow(with: value)
        }
    }
    
    public func flow(with value: Any) {
        _handler(value)
    }
}
