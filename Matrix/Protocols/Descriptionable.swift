//
//  Descriptionable.swift
//  Matrix
//
//  Created by Ostap Tyvonovych on 6/11/19.
//  Copyright © 2019 OstapTyvonovych. All rights reserved.
//

public protocol Descriptionable {
    init?(_ string: String)

    var description: String { get }
}
