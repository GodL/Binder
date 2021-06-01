//
//  Delay.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/10.
//

import Foundation

extension Producable {
    public func delay(_ dueTime: DispatchTimeInterval) -> Binding<Value> {
        DelayBinding(source: self.asBinding(), dueTime: dueTime)
    }
}

final class DelayBinding<Value>: Binding<Value>, Flowable {
    let dueTime: DispatchTimeInterval
    
    init(source: Binding<Value>, dueTime: DispatchTimeInterval) {
        self.dueTime = dueTime
        super.init(wrappedValue: source.wrappedValue)
        self.subscribe(on: source)
    }
    
    func flow(with value: Value) {
        DispatchQueue.main.asyncAfter(deadline: .now() + dueTime) { [value] in
            self.wrappedValue = value
        }
    }
}
