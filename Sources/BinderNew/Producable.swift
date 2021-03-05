//
//  File.swift
//  
//
//  Created by lihao10 on 2021/3/4.
//

public protocol Producable {
    associatedtype Value
    
    func asBinding() -> Binding<Value>
}

public protocol FlowType {
    associatedtype Value
    
    func flow(with value: Value)
    
    func subscribe<Producer: Producable>(on producer: Producer) where Producer.Value == Value
}

extension FlowType {
    public func subscribe<Producer: Producable>(on producer: Producer) where Producer.Value == Value {
        producer.asBinding().subBindings.append(AnyFlow(self))
    }
}

public struct AnyFlow: FlowType {
    
    let _flow: (Any) -> Void
    
    public init<Flow: FlowType>(_ flow: Flow) {
        _flow = {
            guard let value = $0 as? Flow.Value else { fatalError() }
            flow.flow(with: value)
        }
    }
    
    public func flow(with value: Any) {
        _flow(value)
    }
}
