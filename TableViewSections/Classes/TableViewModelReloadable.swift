//
//  TableViewModelType.swift
//
//  Created by zhaoshouwen on 2021/8/4.
//

import UIKit

public extension BaseTableViewModel {
    
    // MARK: 刷新Table View
    func reloadTableView() {
        removeAllNumberOfRowsCacheIfNeeded()
        context.tableView?.reloadData()
    }
    
    func reloadTableViewAndDisplayedSections() {
        removeAllNumberOfRowsCacheIfNeeded()
        displayedSections = sections.filter { $0.section_isDisplay }
        context.tableView?.reloadData()
    }
    
    func reloadTableView(with sections: [TableViewSectionType]) {
        updateSections(sections)
        context.tableView?.reloadData()
    }
    
    func updateTableView(_ changeHandler: (() -> Void)? = nil) {
        guard let tableView = context.tableView else { return }
        tableView.beginUpdates()
        changeHandler?()
        tableView.endUpdates()
    }
    
    // MARK: 刷新Section
    func reloadSection(_ section: TableViewSectionType,
                       with animation: UITableView.RowAnimation) {
        guard let tableView = context.tableView,
              let index = firstIndex(for: section) else { return }
        removeNumberOfRowsCache(for: [section])
        tableView.reloadSections(IndexSet([index]), with: animation)
    }
    
    func reloadSections(_ items: [TableViewSectionType],
                        with animation: UITableView.RowAnimation) {
        guard let tableView = context.tableView else { return }
        let indexs = indexsForSections(items)
        guard !indexs.isEmpty else { return }
        removeNumberOfRowsCache(for: items)
        tableView.reloadSections(IndexSet(indexs), with: animation)
    }
    
    func reloadSection(for identifier: String,
                       with animation: UITableView.RowAnimation) {
        guard let tableView = context.tableView,
              let index = firstIndex(for: identifier) else { return }
        displayedSections[safe: index]
            .run { self.removeNumberOfRowsCache(for: [$0]) }
        tableView.reloadSections(IndexSet([index]), with: animation)
    }
    
    func reloadSections(for identifiers: [String],
                        with animation: UITableView.RowAnimation) {
        guard let tableView = context.tableView else { return }
        let indexs = indexsForIdentifiers(identifiers)
        guard !indexs.isEmpty else { return }
        let sctions = indexs.compactMap { displayedSections[safe: $0] }
        removeNumberOfRowsCache(for: sctions)
        tableView.reloadSections(IndexSet(indexs), with: animation)
    }
    
    // MARK: 删除Section
    func deleteSection(_ section: TableViewSectionType,
                       with animation: UITableView.RowAnimation) {
        guard let tableView = context.tableView,
              let index = firstIndex(for: section) else { return }
        let tmp = displayedSections.remove(at: index)
        _deleteSectionInSections(tmp)
        removeNumberOfRowsCache(for: [tmp])
        tableView.deleteSections(IndexSet([index]), with: animation)
    }
    
    func deleteSections(_ items: [TableViewSectionType],
                        with animation: UITableView.RowAnimation) {
        guard let tableView = context.tableView else { return }
        let indexs = indexsForSections(items)
        guard !indexs.isEmpty else { return }
        indexs.reversed().forEach {
            let tmp = displayedSections.remove(at: $0)
            _deleteSectionInSections(tmp)
            removeNumberOfRowsCache(for: [tmp])
        }
        tableView.deleteSections(IndexSet(indexs), with: animation)
    }
    
    func deleteSection(for identifier: String,
                       with animation: UITableView.RowAnimation) {
        guard let tableView = context.tableView,
              let index = firstIndex(for: identifier) else { return }
        let tmp = displayedSections.remove(at: index)
        _deleteSectionInSections(tmp)
        removeNumberOfRowsCache(for: [tmp])
        tableView.deleteSections(IndexSet([index]), with: animation)
    }
    
    func deleteSections(for identifiers: [String],
                        with animation: UITableView.RowAnimation) {
        guard let tableView = context.tableView else { return }
        let indexs = indexsForIdentifiers(identifiers)
        guard !indexs.isEmpty else { return }
        indexs.reversed().forEach {
            let tmp = displayedSections.remove(at: $0)
            _deleteSectionInSections(tmp)
            removeNumberOfRowsCache(for: [tmp])
        }
        tableView.deleteSections(IndexSet(indexs), with: animation)
    }
}
