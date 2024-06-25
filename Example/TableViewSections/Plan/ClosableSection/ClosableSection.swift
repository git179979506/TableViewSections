//
//  ClosableSection.swift
//  TableViewSections_Example
//
//  Created by zhaoshouwen on 2024/6/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import TableViewSections

class ClosableSection: PlanTableViewSectionType {
    
    var section_isDisplay: Bool = true
    
    // 定义为存储属性，框架内部自动设置
    var context: TableViewSectionsContext?
    
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
        let cell = tableView.ns.dequeueCell(ClosableCell.self.self, for: indexPath)
        cell.onTapCloseButtonClosure = { [weak self] in
            guard let self = self else { return }
            self.section_isDisplay = false
            self.context?.viewModel?.reloadTableViewAndDisplayedSections()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat? {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: 跳转
    }
}
