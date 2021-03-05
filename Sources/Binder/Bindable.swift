//
//  Bindable.swift
//  Binder
//
//  Created by GodL on 2021/2/24.
//

import UIKit

public protocol Bindable {
    associatedtype Value
    
    func bind(with value: Value)
}

