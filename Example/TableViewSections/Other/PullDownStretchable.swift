//
//  PullDownStretchable.swift
//
//  Created by zhaoshouwen on 2019/12/23.
//  下拉放大视图

import UIKit

public protocol PullDownStretchable: class {
    /// 被拉伸的视图
    var stretchableView: UIView { get }
    /// 适用于跟随滑动view的拉伸，在 scrollViewDidScroll  中调用，offset = scrollView.contentOffset.y
    func stretch(with offset: CGFloat, scaleWidth: Bool)
    /// 适用于固定view的拉伸
    func stretchFixed(with offset: CGFloat, scaleWidth: Bool, ratio: CGFloat)
}

public extension PullDownStretchable {
    func stretch(with offset: CGFloat, scaleWidth: Bool = true) {
        if offset < 0 {
            let scale = 1 - offset / stretchableView.bounds.height
            let a = scaleWidth ? scale : 1
            stretchableView.transform = CGAffineTransform(a: a, b: 0, c: 0, d: scale, tx: 0, ty: offset * 0.5)
        } else {
            stretchableView.transform = .identity
        }
    }
    
    func stretchFixed(with offset: CGFloat, scaleWidth: Bool = true, ratio: CGFloat = 1) {
        if offset < 0 {
            let scale = 1 - offset / stretchableView.bounds.height
            let a = scaleWidth ? scale : 1
            stretchableView.transform = CGAffineTransform(a: a, b: 0, c: 0, d: scale, tx: 0, ty: -offset * 0.5 * ratio)
        } else if offset == 0 {
            stretchableView.transform = .identity
        } else {
            stretchableView.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: -offset * ratio)
        }
    }
}

public extension PullDownStretchable where Self: UIView {
    var stretchableView: UIView { return self }
}
