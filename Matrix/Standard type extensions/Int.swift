//
//  Int.swift
//  Matrix
//
//  Created by Ostap Tyvonovych on 4/14/19.
//  Copyright © 2019 OstapTyvonovych. All rights reserved.
//

extension Int: Descriptionable {}

extension Int: Arithmetic {
    public static var one: Int {
        return 1
    }
}

extension Int {
    var isOdd: Bool {
        return (self & 1) == 1
    }
}
