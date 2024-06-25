//
//  BaseTableViewViewModel.swift
//
//
//  Created by zhaoshouwen on 2021/7/29.
//

import UIKit

/// Table View Section架构View Model基类，实现UITableViewDataSource、UITableViewDelegate部分方法的转发
///
/// 基类未实现的方法需要子类自己实现，例如：
///
///     // 转发到section
///     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
///         // code...
///         return displayedSections[safe: indexPath.section]?
///             .tableView(tableView, heightForRowAt: indexPath) ?? tableView.rowHeight
///     }
///
///     // 不转发到section
///     func scrollViewDidScroll(_ scrollView: UIScrollView) {
///         // code...
///     }
///
/// 通过覆写基类已实现方法添加额外的功能，需要调用super，例如：
///
///     override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
///         // 一定要调用super！！！
///         super.tableView(tableView, willDisplay: cell, forRowAt: indexPath)
///         // 实现额外的埋点逻辑
///         if var info = cell.info,
///            let event = info[DJLogger.eventKey]?.int {
///             info.removeValue(forKey: DJLogger.eventKey)
///             info[DJLogger.sourceSymbol] = code
///             container?.log(event: event, info)
///         }
///     }
open class BaseTableViewModel: NSObject {
    public internal(set) lazy var context: TableViewSectionsContext = TableViewSectionsContext(viewModel: self)
    
    /// 所有的Section
    ///
    /// section_isDisplay == true才会显示出来，获取section对应下标请使用displayedSections
    public internal(set) var sections: [TableViewSectionType] = [] {
        didSet {
            sections.forEach { $0.context = context }
        }
    }
    
    /// 显示的Section，section_isDisplay == true
    public internal(set) var displayedSections: [TableViewSectionType] = []
    
    /// 更新sections和displayedSections
    public func updateSections(_ sections: [TableViewSectionType]) {
        self.sections = sections
        displayedSections = sections.filter { $0.section_isDisplay }
        removeAllNumberOfRowsCacheIfNeeded()
    }
    
    /// 关联 tableView，设置上下文
    public func associateTableView(_ tableView: UITableView, viewController: UIViewController? = nil, additional: [String: Any]? = nil) {
        tableView.dataSource = self
        tableView.delegate = self
        context.tableView = tableView
        context.viewController = viewController
        context.additional = additional ?? [:]
    }
    
    // MARK: Number of rows cache
    public var isCachedNumberOfRows: Bool = false
    
    public func removeAllNumberOfRowsCacheIfNeeded() {
        guard isCachedNumberOfRows else { return }
        numberOfRowsTable.removeAllObjects()
    }
    
    public func removeNumberOfRowsCache(for sections: [TableViewSectionType]) {
        guard isCachedNumberOfRows, !sections.isEmpty else { return }
        sections.forEach { numberOfRowsTable.removeObject(forKey: $0) }
    }
    
    public func removeNumberOfRowsCache(for identifiers: [String]) {
        guard isCachedNumberOfRows, !identifiers.isEmpty else { return }
        sectionsForIdentifiers(identifiers)
            .forEach { numberOfRowsTable.removeObject(forKey: $0) }
    }
    
    // MARK: First index in displayed sections
    public func indexsForSections(_ items: [TableViewSectionType]) -> [Int] {
        return items.compactMap(firstIndex)
    }
    
    public func firstIndex(for section: TableViewSectionType) -> Int? {
        return displayedSections.firstIndex { $0 === section }
    }
    
    public func indexsForIdentifiers(_ identifiers: [String]) -> [Int] {
        return identifiers.compactMap(firstIndex)
    }
    
    public func firstIndex(for identifier: String) -> Int? {
        return displayedSections.firstIndex { $0.section_identifier == identifier }
    }
    
    public func sectionsForIdentifiers(_ identifiers: [String]) -> [TableViewSectionType] {
        return identifiers.compactMap(firstSection)
    }
    
    public func firstSection(for identifier: String) -> TableViewSectionType? {
        return displayedSections.first { $0.section_identifier == identifier }
    }
    
    // MARK: Private
    func _deleteSectionInSections(_ section: TableViewSectionType) {
        sections
            .firstIndex { $0 === section }
            .run { self.sections.remove(at: $0) }
    }
    
    lazy var numberOfRowsTable: NSMapTable<AnyObject, NSNumber> = {
        let table = NSMapTable<AnyObject, NSNumber>(keyOptions: .weakMemory,
                                                    valueOptions: .strongMemory,
                                                    capacity: 5)
        return table
    }()
}

extension BaseTableViewModel: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UITableViewDataSource
    open func numberOfSections(in tableView: UITableView) -> Int {
        return displayedSections.count
    }
    
    open func tableView(_ tableView: UITableView,
                        numberOfRowsInSection section: Int) -> Int {
        guard let sec = displayedSections[safe: section] else { return 0 }
        if isCachedNumberOfRows {
            if let number = numberOfRowsTable.object(forKey: sec) {
                return number.intValue
            } else {
                let number = sec.tableView(tableView, numberOfRowsInSection: section)
                numberOfRowsTable.setObject(NSNumber(value: number), forKey: sec)
                return number
            }
        } else {
            return sec.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    open func tableView(_ tableView: UITableView,
                        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return displayedSections[safe: indexPath.section]?
            .tableView(tableView, cellForRowAt: indexPath)
            ?? UITableViewCell(style: .default, reuseIdentifier: "safe")
    }
    
    // MARK: UITableViewDelegate
    open func tableView(_ tableView: UITableView,
                        didSelectRowAt indexPath: IndexPath) {
        displayedSections[safe: indexPath.section]?
            .tableView(tableView, didSelectRowAt: indexPath)
    }
    
    // 如有需要，子类自己实现此方法
//    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return displayedSections[safe: indexPath.section]?
//            .tableView(tableView, heightForRowAt: indexPath) ?? tableView.rowHeight
//    }
    
    // 如有需要，子类自己实现此方法，或使用 EstimatedTableViewModel
//    open func tableView(_ tableView: UITableView,
//                        estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return displayedSections[safe: indexPath.section]?
//            .tableView(tableView, estimatedHeightForRowAt: indexPath)
//            ?? tableView.estimatedRowHeight
//    }
    
    open func tableView(_ tableView: UITableView,
                        heightForHeaderInSection section: Int) -> CGFloat {
        return displayedSections[safe: section]?
            .tableView(tableView, heightForHeaderInSection: section)
            ?? tableView.sectionHeaderHeight
    }
    
    // 如有需要，子类自己实现此方法
//    open func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        return displayedSections[safe: section]?
//            .tableView(tableView,
//                       estimatedHeightForHeaderInSection: section) ?? 0
//    }
    
    open func tableView(_ tableView: UITableView,
                        heightForFooterInSection section: Int) -> CGFloat {
        return displayedSections[safe: section]?
            .tableView(tableView, heightForFooterInSection: section)
            ?? tableView.sectionFooterHeight
    }
    
    // 如有需要，子类自己实现此方法
//    open func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
//        return displayedSections[safe: section]?
//            .tableView(tableView,
//                       estimatedHeightForFooterInSection: section) ?? 0
//    }
    
    open func tableView(_ tableView: UITableView,
                        viewForHeaderInSection section: Int) -> UIView? {
        return displayedSections[safe: section]?
            .tableView(tableView, viewForHeaderInSection: section)
    }
    
    open func tableView(_ tableView: UITableView,
                        viewForFooterInSection section: Int) -> UIView? {
        return displayedSections[safe: section]?
            .tableView(tableView, viewForFooterInSection: section)
    }
    
    open func tableView(_ tableView: UITableView,
                        willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        displayedSections[safe: indexPath.section]?
            .tableView(tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    open func tableView(_ tableView: UITableView,
                        didEndDisplaying cell: UITableViewCell,
                        forRowAt indexPath: IndexPath) {
        displayedSections[safe: indexPath.section]?
            .tableView(tableView, didEndDisplaying: cell, forRowAt: indexPath)
    }
}
