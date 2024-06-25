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

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        viewModel.loadData { error in
            // 一些其他逻辑
        }
    }
    
    let viewModel = PlanType2TableVM()
    
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
