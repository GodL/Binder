//
//  Merge.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/10.
//

extension Producable {
    
    /// Merges all elements of a `binding` sequence into a `binding` value
    /// - Parameter sequence: A sequence `binding` to merge.
    /// - Returns: A `binding` that incorporates a `binding` sequence
    public func merge<S: Sequence>(_ sequence: S) -> Binding<Value> where S.Element : Producable, S.Element.Value == Value {
        MergeBinding(source: self.asBinding(), sequence: sequence)
    }
    
    /// Merges all elements of a `binding` array into a `binding` value
    /// - Parameter sequence: An array `binding` to merge.
    /// - Returns: A `binding` that incorporates a `binding` array
    public func merge<Producer: Producable>(_ producers: Producer ...) -> Binding<Value> where Producer.Value == Value {
        MergeBinding(source: self.asBinding(), sequence: producers)
    }
}

final class MergeBinding<Value>: Binding<Value>, Flowable {
    
    init<S: Sequence>(source: Binding<Value>, sequence: S) where S.Element : Producable, S.Element.Value == Value {
        super.init(wrappedValue: source.wrappedValue)
        self.subscribe(on: source)
        
        sequence.map { $0.asBinding() }.forEach { self.subscribe(on: $0) }
    }
    
    func flow(with value: Value) {
        self.wrappedValue = value
    }
}
