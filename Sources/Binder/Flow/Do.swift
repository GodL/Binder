//
//  Do.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/10.
//

extension Producable {
    
    /// Invokes an action for each event in the `binding`.
    /// - Parameter handler: A action that to invoke
    /// - Returns: The source `binding` with the side-effecting behavior applied.
    public func `do`(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        DoBinding(source: self.asBinding(), handler)
    }
}

final class DoBinding<Value>: Binding<Value>, Flowable {
    let handler: (Value) -> Void
    
    init(source: Binding<Value>, _ handler: @escaping (Value) -> Void) {
        self.handler = handler
        super.init(wrappedValue: source.wrappedValue)
        self.subscribe(on: source)
    }
    
    func flow(with value: Value) {
        self.handler(value)
        self.wrappedValue = value
    }
}
