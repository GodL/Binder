//
//  Drivable.swift
//  Binder
//
//  Created by GodL on 2021/2/25.
//

public protocol Drivable {
    associatedtype Value
    
    func drive(with value: Value)
}

public struct AnyDriver: Drivable {
    let _drive: (Any) -> Void
    
    public init<Driver: Drivable>(_ driver: Driver) {
        _drive = {
            guard let value = $0 as? Driver.Value else { fatalError("type error") }
            driver.drive(with: value)
        }
    }
    
    public func drive(with value: Any) {
        _drive(value)
    }
    
}
