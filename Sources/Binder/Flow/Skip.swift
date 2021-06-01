//
//  Skip.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/11.
//
import Foundation

extension Producable {
    public func skip(_ count: Int) -> Binding<Value> {
        SkipCountBinding(source: self.asBinding(), count: count)
    }
    
    public func skip(_ duration: TimeInterval) -> Binding<Value> {
        
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
            self.wrappedValue = value
            count -= 1
        }
    }
}

final class SkipTimeBinding<Value>: Binding<Value>, Flowable {
    
    let duration: TimeInterval
    
    init(source: Binding<Value>, duration: TimeInterval) {
        self.duration = duration
        super.init(wrappedValue: source.wrappedValue)
        self.subscribe(on: source)
    }
    
    func flow(with value: Value) {
        
    }
}
