//
//  PlanType2ViewController.swift
//  TableViewSections_Example
//
//  Created by zhaoshouwen on 2024/6/22.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import PageState

class PlanType2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .groupTableViewBackground
        
        // 放在 tableView 下面，作为背景
        view.addSubview(topBgImageView)
        topBgImageView.snp.makeConstraints {
            $0.top.leading.width.equalToSuperview()
            $0.height.equalTo(230)
        }
        
        view.addSubview(tableView)
        // tableView 不是根视图，需要自己处理内容填充，不然会产生奇怪的问题
        tableView.contentInsetAdjustmentBehavior = .never

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        topBgImageView.isHidden = true
        viewModel.loadData { [weak topBgImageView] error in
            topBgImageView?.isHidden = false
            // 一些其他逻辑
        }
    }
    
    let viewModel = PlanType2TableVM()
    
    // 定义顶部背景视图
    private let topBgImageView = UIImageView().ns.config{
        $0.image = UIImage(named: "plan_type2_top_bg")
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        viewModel.associateTableView(tableView, viewController: self, additional: nil)
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = 12
        tableView.sectionFooterHeight = .leastNonzeroMagnitude
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // 响应 safeAreaInsets 变更，调整 tableView.contentInset
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        print(view.safeAreaInsets)
        tableView.contentInset = UIEdgeInsets(top: view.safeAreaInsets.top, left: 0, bottom: 0, right: 0)
    }
}


// 遵守 PullDownStretchable 协议
extension PlanType2ViewController: PullDownStretchable {
    // 返回可拉伸的view
    var stretchableView: UIView {
        return topBgImageView
    }
}
