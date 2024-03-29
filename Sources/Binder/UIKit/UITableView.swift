//
//  UITableView.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/10.
//

import UIKit.UITableView

extension Bind where Base : UITableView {
    public var reloadData: Binder<()> {
        Binder(target: self.base) { base, _ in
            base.reloadData()
        }
    }
}
