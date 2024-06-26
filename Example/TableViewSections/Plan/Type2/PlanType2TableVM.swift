//
//  PlanType2TableVM.swift
//  TableViewSections_Example
//
//  Created by zhaoshouwen on 2024/6/23.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import TableViewSections

class PlanType2TableVM: EstimatedTableViewModel {
    
    func loadData(callback: @escaping ErrorTask) {
        context.tableView?.ps.item = PSLabelItem.empty(text: "加载中...")
            .config { item in
                item.layoutOffset = CGPoint(x: 0, y: -150)
            }
        
        // 请求页面框架
        PlanAPI.someApi.reqeust { [weak self] in
            // 可以根据框架数据动态组装section
            let sections: [PlanTableViewSectionType] = [
                ClosableSection(),
                PlanType2HeaderSection(),
                PlanNoticeSection(type: .type2), // section 复用
                PlanType2YieldSection(),
                PlanType2GrowthSection(),
                PlanProfitRatioSection(type: .type2), // section 复用
                PlanHoldingSection(type: .type2), // section 复用
                PlanType2ConfigSection(),
                PlanType2NewPlanSection(),
                PlanManagerSection(type: .type2), // section 复用
                PlanQASection(type: .type2), // section 复用
                PlanTopCommentsSection(type: .type2), // section 复用
            ]
            
            // 请求 sction 的数据
            // 这里每个Section独立请求数据并渲染，可能出现UI跳动的问题
            // 可以给首屏模块设计占位UI样式，或使用缓存数据来解决
            sections.forEach { (sec) in
                sec.loadData { [weak self] (error) in
                    self?.reloadTableViewAndDisplayedSections()
                }
            }
            
            self?.updateSections(sections)
            self?.context.tableView?.ps.item = nil
            callback(nil)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let continer = context.viewController as? PullDownStretchable
        continer?.stretchFixed(with: scrollView.contentOffset.y + scrollView.adjustedContentInset.top)
    }
}
