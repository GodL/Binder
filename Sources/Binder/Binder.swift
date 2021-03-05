
struct AnyBinder<Value>: Bindable {
    
    let _binder: (Value) -> Void
    
    init<Binder: Bindable>(_ binder: Binder) where Binder.Value == Value {
        _binder = {
            binder.bind(with: $0)
        }
    }
    
    func bind(with value: Value) {
        _binder(value)
    }
}

public struct BinderBase<Value>: Bindable {
    
    private let _event: (Value) -> Void
    
    public init<Target: AnyObject>(target: Target, _ bind: @escaping (Target, Value) -> Void) {
        _event = { value in
            bind(target, value)
        }
    }
    
    
    public func bind(with value: Value) {
        _event(value)
    }
}
