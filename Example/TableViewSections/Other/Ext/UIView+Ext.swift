//
//  UIView+Ext.swift
//  TableViewSections_Example
//
//  Created by zhaoshouwen on 2024/6/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

extension NameSpace where Base: UIView {
    /// 注意，初始化属性时 callback 内不能用slef
    func config(callback: (Base) -> Void) -> Base {
        callback(base)
        return base
    }
}
