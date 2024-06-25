//
//  PlanDemoBaseCell.swift
//  TableViewSections_Example
//
//  Created by zhaoshouwen on 2024/6/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class PlanDemoBaseCell<T: PlanDemoBaseModelType>: DemoImageCell {

    func update(with model: T) {
        updateImage(model.demoImageNamed)
    }

}
