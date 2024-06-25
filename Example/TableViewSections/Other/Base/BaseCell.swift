//
//  BaseCell.swift
//  TableViewSections_Example
//
//  Created by zhaoshouwen on 2024/6/22.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureSubviews()
        configureConstraints()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureSubviews()
        configureConstraints()
    }

    open override func awakeFromNib() {
        configureSubviews()
        configureConstraints()
    }

    open func configureSubviews() {}
    open func configureConstraints() {}
}
