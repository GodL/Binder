//
//  Optional.swift
//  https://github.com/GodL/Binder

//  547188371@qq.com
//  Created by GodL on 2021/7/18.
//

extension Producable {
    
    /// Converts a `binding` to anther `binding` that contains optional values
    /// - Returns: A `binding` that contains optional values.
    public func optional() -> Binding<Value?> {
        self.asBinding().map { value in
            let result: Value? = value
            return result
        }
    }
}
