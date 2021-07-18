//
//  Skip.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/11.
//
import Foundation

extension Producable {
    
    /// Bypasses a specified number of values in a `binding`  and then returns the remaining values.
    /// - Parameter count: The number of values to skip.
    /// - Returns: A `binding` that ignores the first count values.
    public func skip(_ count: Int = 1) -> Binding<Value> {
        SkipCountBinding(source: self.asBinding(), count: count)
    }
    
    /// Bypasses a specified time of values in a `binding`  and then returns the remaining values
    /// - Parameter duration: The time of values to skip.
    /// - Returns: A `binding` that ignores the duration time values.
    public func skip(_ duration: TimeInterval) -> Binding<Value> {
        SkipTimeBinding(source: self.asBinding(), duration: duration)
    }
}

final class SkipCountBinding<Value>: Binding<Value>, Flowable {
    
    var count: Int
    
    init(source: Binding<Value>, count: Int) {
        self.count = count
        super.init(wrappedValue: source.wrappedValue)
        self.subscribe(on: source)
    }
    
    func flow(with value: Value) {
        if count != 0 {
            count -= 1
            return
        }
        self.wrappedValue = value
    }
}

final class SkipTimeBinding<Value>: Binding<Value>, Flowable {
    
    let duration: TimeInterval
    
    var flag: Bool = false
    
    init(source: Binding<Value>, duration: TimeInterval) {
        self.duration = duration
        super.init(wrappedValue: source.wrappedValue)
        self.subscribe(on: source)
    }
    
    override func bind(_ consumer: AnyConsumer<Value>) {
        super.bind(consumer)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.flag = true
        }
    }
    
    func flow(with value: Value) {
        if flag {
            self.wrappedValue = wrappedValue
        }
    }
}
