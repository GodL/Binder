//
//  File.swift
//  
//
//  Created by lihao10 on 2021/3/3.
//

extension State {
    public func ignoreValues() -> State<Void> {
        let ignore = IgnoreState(wrappedValue: ())
        self.drivers.append(AnyDriver(ignore))
        return ignore
    }
}

final class IgnoreState: State<Void>, Drivable {
    func drive(with value: Void) {
        self.wrappedValue = ()
    }
    
}
