//
//  BaseCardCell.swift
//  TableViewSections_Example
//
//  Created by zhaoshouwen on 2024/6/22.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

open class BaseCardView: BaseView {
    public var cornerStyle: CornerStyle = .none {
        didSet {
            updateCornerStyle()
        }
    }
    
    public var cornerRadius: CGFloat = 12 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    public override func configureSubviews() {
        backgroundColor = UIColor.white
    }
    
    
    func updateCornerStyle() {
        switch cornerStyle {
        case .none:
            layer.mask = nil
            layer.cornerRadius = 0
        case .first:
            layer.cornerRadius = cornerRadius
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .last:
            layer.cornerRadius = cornerRadius
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .single:
            layer.cornerRadius = cornerRadius
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
            
        case .custom(let corners):
            layer.cornerRadius = cornerRadius
            layer.maskedCorners = corners.caCornerMask
        }
    }
    
    public enum CornerStyle {
        case none
        /// 第一个cell 左上、右上有圆角
        case first
        /// 最后一个cell 左下、右下有圆角
        case last
        /// 单个cell 全部圆角
        case single
        /// 自定义圆角
        case custom(corners: UIRectCorner)
    }
}

class BaseCardCell: BaseCell {
    
    var cornerStyle: BaseCardView.CornerStyle = .none {
        didSet {
            cardView.cornerStyle = cornerStyle
        }
    }
    
    var cornerRadius: CGFloat = 12 {
        didSet {
            cardView.cornerRadius = cornerRadius
        }
    }
    
    var edgeInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16) {
        didSet {
            edgeInsetConstraint?.update(inset: edgeInset)
        }
    }
    
    private var edgeInsetConstraint: Constraint?


    public override func configureSubviews() {
        backgroundColor = .clear
        cardView.backgroundColor = UIColor.white
        contentView.addSubview(cardView)
    }
    
    public override func configureConstraints() {
        cardView.snp.makeConstraints {
            edgeInsetConstraint = $0.edges.equalToSuperview().inset(edgeInset).constraint
        }
    }
    
    lazy var cardView = BaseCardView()
}

extension UIRectCorner {
    var caCornerMask: CACornerMask {
        var mask: CACornerMask = []
        if contains(.topLeft) {
            mask.insert(.layerMinXMinYCorner)
        }
        if contains(.topRight) {
            mask.insert(.layerMaxXMinYCorner)
        }
        if contains(.bottomLeft) {
            mask.insert(.layerMinXMaxYCorner)
        }
        if contains(.bottomRight) {
            mask.insert(.layerMaxXMaxYCorner)
        }
        return mask
    }
}
