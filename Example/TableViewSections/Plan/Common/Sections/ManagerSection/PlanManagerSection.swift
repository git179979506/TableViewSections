//
//  PlanManagerSection.swift
//  TableViewSections_Example
//
//  Created by zhaoshouwen on 2024/6/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import TableViewSections

class PlanManagerSection: PlanTableViewSectionType {
    
    let type: PlanType
    
    var model: PlanManagerModel?
    
    // 控制Section是否显示
    var section_isDisplay: Bool = false
    
    init(type: PlanType) {
        self.type = type
    }
    
    func loadCache() {
        // 按需加载缓存数据
    }
    
    // 网络请求
    func loadData(callback: @escaping ErrorTask) {
        PlanAPI.otherApi(params: ["type": type.rawValue]).reqeust { [weak self] in
            defer { callback(nil) }
            guard let self = self else { return }
            self.section_isDisplay = true
            self.model = PlanManagerModel(demoImageNamed: "plan_\(self.type.rawValue)_manager")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model == nil ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ns.dequeueCell(PlanManagerCell.self, for: indexPath)
        model.run(cell.update(with:))
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat? {
        return 768
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: 跳转
    }
}
