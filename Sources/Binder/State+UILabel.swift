//
//  File.swift
//  
//
//  Created by lihao10 on 2021/2/24.
//

import UIKit

extension UILabel {
    public var stateTitle: BinderBase<String?> {
        BinderBase(target: self) {
            $0.text = $1
        }
    }
}

extension UITableView {
    public var reload: BinderBase<Void> {
        BinderBase(target: self) { tableView, _ in
            tableView.reloadData()
        }
    }
}



