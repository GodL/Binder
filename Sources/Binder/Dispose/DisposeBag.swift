//
//  DisposeBag.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/7/20.
//

public class DisposeBag: Disposable {
    let disposes: [Disposable]
    
    public init(_ disposes: Disposable ...) {
        self.disposes = disposes
    }
    
    public init (_ disposes: [Disposable]) {
        self.disposes = disposes
    }
    
    public func dispose() {
        for dispose in disposes {
            dispose.dispose()
        }
    }
    
    deinit {
        self.dispose()
    }
}
