//
//  TableViewSectionType.swift
//
//  Created by zhaoshouwen on 2021/7/28.
//

import UIKit

public protocol SectionDisplayable {
    var section_isDisplay: Bool { get }
}

public extension SectionDisplayable {
    var section_isDisplay: Bool { return true }
}

public protocol SectionIdentifiable {
    var section_identifier: String { get }
}

public extension SectionIdentifiable {
    var section_identifier: String {
        return "\(Self.self)"
    }
}


public protocol TableViewSectionType: AnyObject, SectionDisplayable, SectionIdentifiable {
    // MARK: 注册cell、header、footer
    /// 建议使用Cell自动注册：https://juejin.cn/post/7195005912653856827
    static func register(for tableView: UITableView)
    
    /// Section 想要获取 context，需要定义为存储属性
    var context: TableViewSectionsContext? { get set}
    
    // MARK: 转发 table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    
    /// BaseTableViewModel没有实现此方法的转发，需要使用时子类自己实现
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat?
    /// BaseTableViewModel没有实现此方法的转发，可以使用 EstimatedTableViewModel 或子类自己实现
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat?
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat?
    /// BaseTableViewModel没有实现此方法的转发，需要使用时子类自己实现
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat?
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat?
    /// BaseTableViewModel没有实现此方法的转发，需要使用时子类自己实现
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat?
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
}

public extension TableViewSectionType {
    static func register(for tableView: UITableView) { }
    var context: TableViewSectionsContext? {
        get { return nil }
        set { }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat? { return nil }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat? { return nil }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat? { return nil }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat? { return nil}
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat? { return nil }
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat? { return nil }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { return nil }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { return nil }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {}
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {}
}
