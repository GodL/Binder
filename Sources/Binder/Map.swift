//
//  Map.swift
//  Binder
//
//  Created by GodL on 2021/2/24.
//

extension State {
    public func map<Result>(_ transform: @escaping (Value) -> Result) -> State<Result> {
        let map = MapState(wrappedValue: self.wrappedValue, transform)
        self.drivers.append(AnyDriver(map))
        return map
    }
}

final class MapState<Value, Result>: State<Result>, Drivable {
    
    let _transform: (Value) -> Result

    init(wrappedValue: Value, _ transform: @escaping (Value) -> Result) {
        _transform = transform
        super.init(wrappedValue: transform(wrappedValue))
    }
    
    func drive(with value: Value) {
        self.wrappedValue = _transform(value)
    }
}
