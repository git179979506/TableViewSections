//
//  PlanType1GrowthSection.swift
//  TableViewSections_Example
//
//  Created by zhaoshouwen on 2024/6/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import TableViewSections

class PlanType1GrowthSection: PlanTableViewSectionType {
    
    let model = PlanType1GrowthModel()
    
    func loadCache() {
        // 按需加载缓存数据
    }
    
    // 网络请求
    func loadData(callback: @escaping ErrorTask) {
        PlanAPI.someApi.reqeust {
            callback(nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ns.dequeueCell(PlanType1GrowthCell.self.self, for: indexPath)
        cell.update(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat? {
        return 500
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: 跳转
    }
}
