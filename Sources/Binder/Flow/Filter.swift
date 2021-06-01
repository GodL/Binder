//
//  Filter.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/10.
//

extension Producable {
    public func filter(_ predicate: @escaping (Value) -> Bool) -> Binding<Value> {
        FilterBindings(source: self.asBinding(), predicate)
    }
}

final class FilterBindings<Value>: Binding<Value>, Flowable {
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
