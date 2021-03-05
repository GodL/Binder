//
//  File.swift
//  
//
//  Created by lihao10 on 2021/3/5.
//

extension Binding {
    public func map<Result>(_ transform: @escaping (Value) -> Result) -> Binding<Result> {
        let map = MapBinding(source: self.asBinding(), transform)
        return map
    }
}

final class MapBinding<Value, Result>: Binding<Result>, FlowType {
    let transform: (Value) -> Result
    
    init(source: Binding<Value>, _ transform: @escaping (Value) -> Result) {
        self.transform = transform
        super.init(wrappedValue: transform(source.wrappedValue))
        self.subscribe(on: source)
    }
    
    func flow(with value: Value) {
        self.wrappedValue = transform(value)
    }
}
