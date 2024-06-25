//
//  ClosableCell.swift
//  TableViewSections_Example
//
//  Created by zhaoshouwen on 2024/6/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class ClosableCell: BaseCardCell {
    
    var onTapCloseButtonClosure: VoidTask?
    
    override func configureSubviews() {
        super.configureSubviews()
        cornerStyle = .single
        
        label.text = "这是一个可关闭的 Section，演示 section_isDisplay 的一种用法"
        label.numberOfLines = 0
        cardView.addSubview(label)
        cardView.addSubview(button)
        
        button.addTarget(self, action: #selector(onTapCloseButton), for: .touchUpInside)
    }
    
    @objc func onTapCloseButton() {
        print("onTapCloseButton")
        onTapCloseButtonClosure?()
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.top.bottom.equalToSuperview().inset(12)
            make.right.lessThanOrEqualTo(button.snp.left).offset(-12)
        }
        
        button.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(12)
            make.width.equalTo(40)
            make.centerY.equalToSuperview()
        }
    }
    
    let label = UILabel()
    
    let button = UIButton(type: .custom).ns.config {
        $0.setTitle("关闭", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
    }
}
