//
//  EstimatedTableViewSectionType.swift
//  TableViewSections
//
//  Created by zhaoshouwen on 2024/6/22.
//

import UIKit

open class EstimatedTableViewModel: BaseTableViewModel {
    
    open func tableView(_ tableView: UITableView,
                        estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return displayedSections[safe: indexPath.section]?
            .tableView(tableView, estimatedHeightForRowAt: indexPath)
            ?? tableView.estimatedRowHeight
    }
    
}
