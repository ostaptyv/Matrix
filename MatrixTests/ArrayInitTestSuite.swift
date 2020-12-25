//
//  ArrayInitTestSuite.swift
//  MatrixTests
//
//  Created by Ostap Tyvonovych on 25.12.2020.
//  Copyright © 2020 OstapTyvonovych. All rights reserved.
//

import XCTest
@testable import Matrix

class ArrayInitTestSuite: XCTestCase {
    
    func testArrayInit() {
        let emptyArray = [[Int]]()
        let emptyMatrix = Matrix<Int>(array: emptyArray)
        
        XCTAssertNil(emptyMatrix)
        
        let spoiledArray = [
        [1, 2, 3],
        [3, 5, 6],
        [2, 1]
        ]
        let spoiledMatrix = Matrix<Int>(array: spoiledArray)

        XCTAssertNil(spoiledMatrix)
        
        let array = [
        [1, 4, 2, 3],
        [8, 0, 0, 1],
        [-6, -10, 4, 7]
        ]
        let matrix = Matrix<Int>(array: array)
        
        XCTAssertNotNil(matrix)
        XCTAssertEqual(matrix!.size.rows, 3)
        XCTAssertEqual(matrix!.size.columns, 4)
    }
}
