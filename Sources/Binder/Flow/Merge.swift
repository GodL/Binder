//
//  Merge.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/10.
//

extension Producable {
    public func merge<S: Sequence>(_ sequence: S) -> Binding<Value> where S.Element : Producable, S.Element.Value == Value {
        MergeBinding(source: self.asBinding(), sequence: sequence)
    }
    
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
