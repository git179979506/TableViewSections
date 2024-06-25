//
//  Optional+Ext.swift
//  TableViewSections
//
//  Created by zhaoshouwen on 2024/6/3.
//

import Foundation

typealias Exec<T> = (T) -> Void

extension Optional {
    /// Runs a block to Wrapped if not nil
    ///
    ///        let foo: String? = nil
    ///        foo.run { unwrappedFoo in
    ///            // block will never run sice foo is nill
    ///            print(unwrappedFoo)
    ///        }
    ///
    ///        let bar: String? = "bar"
    ///        bar.run { unwrappedBar in
    ///            // block will run sice bar is not nill
    ///            print(unwrappedBar) -> "bar"
    ///        }
    ///
    /// - Parameter exec: a block to run if self is not nil.
    func run(_ exec: Exec<Wrapped>?) {
        guard let exec = exec else { return }
        _ = map(exec)
    }
}
