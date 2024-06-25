//
//  PlanType2HeaderSection.swift
//  TableViewSections_Example
//
//  Created by zhaoshouwen on 2024/6/23.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import TableViewSections

class PlanType2HeaderSection: PlanTableViewSectionType {
    
    let model = PlanType2HeaderModel()
    
    // 控制Section是否显示
    var section_isDisplay: Bool = false
    
    func loadCache() {
        // 按需加载缓存数据
    }
    
    // 网络请求
    func loadData(callback: @escaping ErrorTask) {
        PlanAPI.someApi.reqeust {
            self.section_isDisplay = true
            callback(nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ns.dequeueCell(PlanType2HeaderCell.self, for: indexPath)
        cell.update(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat? {
        return 255
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: 跳转
    }
}
