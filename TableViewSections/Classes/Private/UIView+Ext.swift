//
//  UIView+Ext.swift
//  TableViewSections
//
//  Created by zhaoshouwen on 2024/6/24.
//

import UIKit

extension UIView {
    /// SwifterSwift: Get view's parent view controller
    var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
