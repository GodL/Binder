//
//  Map.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/10.
//

extension Producable {
    
    /// Converts a value in a `binding` to another value
    /// - Parameter transform: A function that convert values.
    /// - Returns: A `binding`that contains the converted value
    public func map<Result>(_ transform: @escaping (Value) -> Result) -> Binding<Result> {
        MapBinding(source: self.asBinding(), transform)
    }
    
    /// Converts a value in a `binding` to  `Void`.
    /// - Returns: A `binding`that contains  `Void`.
    public func mapVoid() -> Binding<Void> {
        MapBinding(source: self.asBinding()) { _ in
            ()
        }
    }
}

final class MapBinding<Value, Result>: Binding<Result>, Flowable {
    
    typealias Value = Value
    
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
