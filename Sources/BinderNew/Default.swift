//
//  File.swift
//  
//
//  Created by lihao10 on 2021/3/5.
//

@propertyWrapper
public struct Default<Value> {
    
    private let defaultValue: Value
    
    private var _value: Value?
    
    public var wrappedValue: Value? {
        set {
            _value = newValue
        }
        
        get {
            _value ?? defaultValue
        }
    }
    
    public init(defaultValue: Value) {
        self.defaultValue = defaultValue
    }
    
    public init(wrappedValue: Value?, defaultValue: Value) {
        self.defaultValue = defaultValue
        self.wrappedValue = wrappedValue
    }
    
    public init() where Value : Defaultable, Value.Value == Value  {
        self.init(defaultValue: Value.defaultValue)
    }
    
    public init(wrappedValue: Value?) where Value : Defaultable, Value.Value == Value {
        self.init(defaultValue: Value.defaultValue)
        self.wrappedValue = wrappedValue
    }
    
}

public protocol Defaultable {
    associatedtype Value
    static var defaultValue: Value { get }
}

extension String: Defaultable {
    public static var defaultValue: String {
        ""
    }
}

extension Int: Defaultable {
    public static var defaultValue: Int {
        0
    }
}


