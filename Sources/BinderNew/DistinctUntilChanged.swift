//
//  File.swift
//  
//
//  Created by lihao10 on 2021/3/5.
//

extension Producable where Value : Equatable {
    public func distinctUntilChanged() -> Binding<Value> {
        let distinctUntilChanged = DistinctUntilChangedBinding(source: self.asBinding())
        return distinctUntilChanged
    }
}

final class DistinctUntilChangedBinding<Value>: Binding<Value>, FlowType where Value : Equatable {
    
    init(source: Binding<Value>) {
        super.init(wrappedValue: source.wrappedValue)
        self.subscribe(on: source)
    }
    
    func flow(with value: Value) {
        if value != self.wrappedValue {
            self.wrappedValue = value
        }
    }
}
