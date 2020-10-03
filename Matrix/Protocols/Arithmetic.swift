//
//  Arithmetic.swift
//  Matrix
//
//  Created by Ostap Tyvonovych on 4/14/19.
//  Copyright © 2019 OstapTyvonovych. All rights reserved.
//

public protocol Arithmetic: Comparable {
    static func + (left: Self, right: Self) -> Self
    static func += (left: inout Self, right: Self)
    static func * (left: Self, right: Self) -> Self
    static func *= (left: inout Self, right: Self)
    static func / (left: Self, right: Self) -> Self
    static func /= (left: inout Self, right: Self)
    static func - (left: Self, right: Self) -> Self
    static prefix func - (right: Self) -> Self
    
    static var one: Self { get }
    static var zero: Self { get }
}
