//
//  DistinctUntilChanged.swift
//  https://github.com/GodL/Binder
//  
//  547188371@qq.com
//  Created by GodL on 2021/7/18.
//

extension Producable {
    
    /// Returns a Binding PropertyWrapper that contains only distinct contiguous values according to equality operator.
    /// - Returns: A Binding PropertyWrapper only containing the distinct contiguous values,
    public func distinctUntilChanged() -> Binding<Value> where Value : Equatable {
        self.distinctUntilChanged { $0 == $1 }
    }
    
    /// Returns a Binding PropertyWrapper that contains only distinct contiguous values according to the `keySelector'`.
    /// - Parameter keySelector: Used to convert a value to an equable value
    /// - Returns: A Binding PropertyWrapper only containing the distinct contiguous values,
    public func distinctUntilChanged<Key: Equatable>(_ keySelector: @escaping (Value) -> Key) -> Binding<Value> {
        self.distinctUntilChanged(keySelector) { $0 == $1 }
    }
    
    /// Returns a Binding PropertyWrapper that contains only distinct contiguous values according to the `comparer'.
    /// - Parameter comparer: Used to compare two values for equality
    /// - Returns: A Binding PropertyWrapper only containing the distinct contiguous values,
    public func distinctUntilChanged(_ comparer: @escaping (Value, Value) -> Bool) -> Binding<Value> {
        self.distinctUntilChanged({ $0 }, comparer: comparer)

    }
    
    /// Returns a Binding PropertyWrapper that contains only distinct contiguous values according to the `keySelector' and `comparer`.
    /// - Parameters:
    ///   - keySelector: A function to transform each value.
    ///   - comparer: A function to compare whether adjacent values are equal
    /// - Returns: A Binding PropertyWrapper only containing the distinct contiguous values,
    public func distinctUntilChanged<Key>(_ keySelector: @escaping (Value) -> Key,
                                          comparer: @escaping (Key, Key) -> Bool) -> Binding<Value> {
        DistinctUntilChangedBinding(source: self.asBinding(), keySelector: keySelector, comparer: comparer)
    }
}

final class DistinctUntilChangedBinding<Value, Key>: Binding<Value>, Flowable {
    var currentKey: Key? = nil
    
    let keySelector: (Value) -> Key
    
    let comparer: (Key, Key) -> Bool
    
    init(source: Binding<Value>, keySelector: @escaping (Value) -> Key, comparer: @escaping (Key, Key) -> Bool) {
        self.keySelector = keySelector
        self.comparer = comparer
        super.init(wrappedValue: source.wrappedValue)
        self.subscribe(on: source)
    }
    
    func flow(with value: Value) {
        let currentKey = keySelector(value)
        if let key = self.currentKey, comparer(key, currentKey) {
            return
        }
        self.currentKey = currentKey
        self.wrappedValue = value
    }
}
