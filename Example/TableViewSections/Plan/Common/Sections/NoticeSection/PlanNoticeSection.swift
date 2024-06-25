//
//  PlanNoticeSection.swift
//  TableViewSections_Example
//
//  Created by zhaoshouwen on 2024/6/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import TableViewSections

class PlanNoticeSection: PlanTableViewSectionType {
    
    let type: PlanType
    
    var model: PlanNoticeModel?
    
    var context: TableViewSectionsContext?
    
    // 控制Section是否显示
    var section_isDisplay: Bool = false
    
    init(type: PlanType) {
        self.type = type
    }
    
    func loadCache() {
        // 按需加载缓存数据
    }
    
    // 使用Cell自动注册逻辑，可不用实现这个方法 https://juejin.cn/post/7195005912653856827
//    static func register(for tableView: UITableView) {
//        // 注册用到的Cell，外部需要调用这个方法进行注册
//    }
    
    // 网络请求
    func loadData(callback: @escaping ErrorTask) {
        PlanAPI.otherApi(params: ["type": type.rawValue]).reqeust { [weak self] in
            defer { callback(nil) }
            guard let self = self else { return }
            self.section_isDisplay = true
            self.model = PlanNoticeModel(demoImageNamed: "plan_\(self.type.rawValue)_notice")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model == nil ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cell 自动注册 https://juejin.cn/post/7195005912653856827
        let cell = tableView.ns.dequeueCell(PlanNoticeCell.self, for: indexPath)
        model.run(cell.update(with:))
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat? {
        return 768
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: 跳转
        let vc = DemoDetailViewController()
        vc.navigationItem.title = "通知详情"
        context?.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
