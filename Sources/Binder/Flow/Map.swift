//
//  Map.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/10.
//

extension Producable {
    public func map<Result>(_ transform: @escaping (Value) -> Result) -> Binding<Result> {
        MapBinding(source: self.asBinding(), transform)
    }
    
    public func mapVoid() -> Binding<Void> {
        MapBinding(source: self.asBinding()) { _ in
            ()
        }
    }
}

final class MapBinding<Value, Result>: Binding<Result>, Flowable {
    let transform: (Value) -> Result
    
    init(source: Binding<Value>, _ transform: @escaping (Value) -> Result) {
        self.transform = transform
        super.init(wrappedValue: transform(source.wrappedValue))
        self.subscribe(on: source)
    }
    
    func flow(with value: Value) {
        self.wrappedValue = self.transform(value)
    }
}
