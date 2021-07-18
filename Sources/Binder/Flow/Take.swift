//
//  Take.swift
//  https://github.com/GodL/Binder
//  
//  547188371@qq.com
//  Created by GodL on 2021/7/18.
//

import Foundation

extension Producable {
    
    /// Returns a specified number of contiguous values from the start of a `binding` .
    /// - Parameter count: The number to take.
    /// - Returns: A `binding` containing only the values of the previous count
    public func take(_ count: Int = 1) -> Binding<Value> {
        TakeCountBinding(source: self.asBinding(), count: count)
    }
    
    /// Takes values for the specified duration from the start of the `binding`, using the main queue to run timers.
    /// - Parameter duration: Duration for taking values from the start of the `binding`..
    /// - Returns: A `binding` with the values taken during the specified duration from the start of the source `binding`.
    public func take(_ duration: TimeInterval) -> Binding<Value> {
        TakeTimeBinding(source: self.asBinding(), duration: duration)
    }
}

final class TakeCountBinding<Value>: Binding<Value>, Flowable {
    
    var count: Int
    
    init(source: Binding<Value>, count: Int) {
        self.count = count
        super.init(wrappedValue: source.wrappedValue)
        self.subscribe(on: source)
    }
    
    func flow(with value: Value) {
        if count != 0 {
            count -= 1
            self.wrappedValue = value
        }
    }
}

final class TakeTimeBinding<Value>: Binding<Value>, Flowable {
    let duration: TimeInterval
    
    var flag: Bool = true
    
    init(source: Binding<Value>, duration: TimeInterval) {
        self.duration = duration
        super.init(wrappedValue: source.wrappedValue)
        self.subscribe(on: source)
    }
    
    override func bind(_ consumer: AnyConsumer<Value>) {
        super.bind(consumer)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.flag = false
        }
    }
    
    func flow(with value: Value) {
        if flag {
            self.wrappedValue = value
        }
    }
}
