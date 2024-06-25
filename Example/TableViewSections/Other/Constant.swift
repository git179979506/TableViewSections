//
//  Constant.swift
//  TableViewSections
//
//  Created by zhaoshouwen on 2024/6/3.
//

import Foundation

public typealias VoidTask = () -> Void
public typealias OneParamTask<P> = (P) -> Void
public typealias TwoParamTask<P1, P2> = (P1, P2) -> Void
public typealias ThreeParamTask<P1, P2, P3> = (P1, P2, P3) -> Void
public typealias FourParamTask<P1, P2, P3, P4> = (P1, P2, P3, P4) -> Void

public typealias VoidTaskWithReturn<R> = () -> R
public typealias OneParamTaskWithReturn<P, R> = (P) -> R
public typealias TwoParamTaskWithReturn<P1, P2, R> = (P1, P2) -> R
public typealias ThreeParamTaskWithReturn<P1, P2, P3, R> = (P1, P2, P3) -> R
public typealias FourParamTaskWithReturn<P1, P2, P3, P4, R> = (P1, P2, P3, P4) -> R
