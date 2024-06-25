//
//  TableViewSectionsContext.swift
//  TableViewSections
//
//  Created by zhaoshouwen on 2024/6/24.
//

import UIKit

public class TableViewSectionsContext {
    public internal(set) weak var viewModel: BaseTableViewModel?
    
    /// 上下文 - UITableView
    public weak var tableView: UITableView?
    
    /// 上下文 - 控制器
    /// - 如果外部没有设置，返回 tableView?.parentViewController
    public var viewController: UIViewController? {
        set {
            _viewController = newValue
        }
        get {
            if _viewController == nil {
                _viewController = tableView?.parentViewController
            }
            return _viewController
        }
    }
    
    /// 上下文 - 附加信息
    public var additional: [String: Any] = [:]
    
    private weak var _viewController: UIViewController?
    
    init(viewModel: BaseTableViewModel) {
        self.viewModel = viewModel
    }
}
