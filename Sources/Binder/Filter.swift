//
//  Filter.swift
//  Binder
//
//  Created by GodL on 2021/2/24.
//

extension State {
    public func filter(_ predicate: @escaping (Value) -> Bool) -> State<Value> {
        let filter = FilterState(wrappedValue: self.wrappedValue, predicate)
        self.drivers.append(AnyDriver(filter))
        return filter
    }
}

final class FilterState<Value>: State<Value>, Drivable {
    
    let predicate: (Value) -> Bool
    
    init(wrappedValue: Value, _ predicate: @escaping (Value) -> Bool) {
        self.predicate = predicate
        super.init(wrappedValue: wrappedValue)
    }
    
    func drive(with value: Value) {
        if predicate(value) {
            self.wrappedValue = value
        }
    }
}
