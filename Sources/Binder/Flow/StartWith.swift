//
//  StartWith.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/10.
//

extension Producable {
    public func start() -> Binding<Value> {
        StartWithBinding(source: self.asBinding())
    }
}

final class StartWithBinding<Value>: Binding<Value>, Flowable {
    
    init(source: Binding<Value>) {
        super.init(wrappedValue: source.wrappedValue)
        self.subscribe(on: source)
    }
    
    override func bind(_ consumer: AnyConsumer<Value>) {
        super.bind(consumer)
        consumer.consume(with: self.wrappedValue)
        self.wrappedValue = self.wrappedValue
    }
    
    func subscribe<Producer>(on producer: Producer) where Producer : Producable, Self.Value == Producer.Value {
        producer.asBinding().flows.append(AnyFlow(self))
        self.wrappedValue = self.wrappedValue
    }
    
    func flow(with value: Value) {
        self.wrappedValue = value
    }
}
