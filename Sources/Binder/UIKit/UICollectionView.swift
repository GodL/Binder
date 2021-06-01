//
//  UICollectionView.swift
//  https://github.com/GodL/Binder
//
//  547188371@qq.com
//  Created by GodL on 2021/3/10.
//

import UIKit

extension Bind where Base : UICollectionView {
    
    public var reloadData: Binder<()> {
        Binder(target: self.base) { base, _ in
            base.reloadData()
        }
    }
}
