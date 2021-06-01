//
//  CompactMap.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/10.
//

extension Producable {
    public func compactMap<Result>(first: Result, _ transform: @escaping (Value) -> Result?) -> Binding<Result> {
        CompactMapBinding(source: self.asBinding(), transform)
    }
}

final class CompactMapBinding<Value, Result>: Binding<Result>, Flowable {
    let transform: (Value) -> Result?
    
    init(source: Binding<Value>, first: Result, _ transform: @escaping (Value) -> Result?) {
        self.transform = transform
        super.init(wrappedValue: first)
        self.subscribe(on: source)
    }
    
    func flow(with value: Value) {
        if let result = self.transform(value) {
            self.wrappedValue = result
        }
    }
}
