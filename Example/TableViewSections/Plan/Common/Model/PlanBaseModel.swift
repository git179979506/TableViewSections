//
//  PlanBaseModel.swift
//  TableViewSections_Example
//
//  Created by zhaoshouwen on 2024/6/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

enum PlanType: String {
    case type1
    case type2
}

// Demo中使用截图代替UI布局，没有数据解析，实际开发中需要
// 定义 Header Section 的数据模型
protocol PlanDemoBaseModelType {
    var demoImageNamed: String { get }
}
