//
//  PlanType1ViewController.swift
//  TableViewSections_Example
//
//  Created by zhaoshouwen on 2024/6/22.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import PageState

/*
 rate
 */

class PlanType1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.ps.item = PSLabelItem.empty(text: "加载中...")
            .config { item in
                item.layoutOffset = CGPoint(x: 0, y: -150)
            }
        viewModel.loadData { [weak tableView] error in
            tableView?.ps.item = nil
        }
    }
    
    let viewModel = PlanType1TableVM()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        viewModel.associateTableView(tableView, viewController: self, additional: nil)
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = 12
        tableView.sectionFooterHeight = .leastNonzeroMagnitude
        return tableView
    }()

}
