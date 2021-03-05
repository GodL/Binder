//
//  File.swift
//  
//
//  Created by lihao10 on 2021/3/5.
//

extension Producable {
    public func filter(_ predicate: @escaping (Value) -> Bool) -> Binding<Value> {
        let filter = FilterBinding(source: self.asBinding(), predicate)
        return filter
    }
}

final class FilterBinding<Value>: Binding<Value>, FlowType {
    let predicate: (Value) -> Bool
    
    init(source: Binding<Value>, _ predicate: @escaping (Value) -> Bool) {
        self.predicate = predicate
        super.init(wrappedValue: source.wrappedValue)
        self.subscribe(on: source)
    }
    
    func flow(with value: Value) {
        if predicate(value) {
            self.wrappedValue = value
        }
    }
}
