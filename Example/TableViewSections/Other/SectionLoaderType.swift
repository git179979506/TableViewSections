//
//  SectionLoaderType.swift
//  TableViewSections_Example
//
//  Created by zhaoshouwen on 2024/6/23.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

typealias ErrorTask = OneParamTask<Error?>

protocol SectionLoaderType {
    func loadCache()
    func loadData(callback: @escaping ErrorTask)
}

extension SectionLoaderType {
    func loadCache() { }
    
    func loadData(callback: @escaping ErrorTask) {
        callback(nil)
    }
}
