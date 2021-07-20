//
//  AnyDispose.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/7/20.
//

public struct AnyDispose: Disposable {
    let handler: () -> Void
    
    
    public init(_ handler: @escaping () -> Void) {
        self.handler = handler
    }
    
    public init(dispose: Disposable) {
        self.init {
            dispose.dispose()
        }
    }
    
    public func dispose() {
        handler()
    }
}
