//
//  LosslessStringConvertibleTestSuite.swift
//  MatrixTests
//
//  Created by Ostap Tyvonovych on 25.12.2020.
//  Copyright © 2020 OstapTyvonovych. All rights reserved.
//

import XCTest
@testable import Matrix

class LosslessStringConvertibleTestSuite: XCTestCase {

    func testStringInit() {
        let emptyString = ""
        let emptyMatrix = Matrix<Int>(emptyString)
        
        XCTAssertNil(emptyMatrix)
        
        let spoiledString = """
        1 2 3 4
        1 3   4
        """
        let spoiledMatrix = Matrix<Int>(spoiledString)
        
        XCTAssertNil(spoiledMatrix)
        
        let foreignCharacters = """
        1 2 g 4
        1 2m msq4
        """
        let matrixWithForeignCharaters = Matrix<Int>(foreignCharacters)
        
        XCTAssertNil(matrixWithForeignCharaters)
        
        let invalidForm1 = """
        121 221 2
        12  3-2 1
        """
        let invalidForm2 = """
        0.0 2.1 4.5
        2.4 3.4 2.3
        1.0 7.8.4 3.0
        """
        let matrixWithInvalidForm1 = Matrix<Int>(invalidForm1)
        let matrixWithInvalidForm2 = Matrix<Double>(invalidForm2)
        
        XCTAssertNil(matrixWithInvalidForm1)
        XCTAssertNil(matrixWithInvalidForm2)
        
        let correctString = """
        1 2 3 5 6 4
        1 4 3 4 5 6
        """
        let matrix = Matrix<Int>(correctString)
        
        XCTAssertNotNil(matrix)
        XCTAssertEqual(matrix!.size.rows, 2)
        XCTAssertEqual(matrix!.size.columns, 6)
        
        let stringWithBigSpaces = """
           1 2 3    4
        1  3 5  3
         42  4 4 4
        """
        let matrixWithBigSpaces = Matrix<Int>(stringWithBigSpaces)
        
        XCTAssertNotNil(matrixWithBigSpaces)
        XCTAssertEqual(matrixWithBigSpaces!.size.rows, 3)
        XCTAssertEqual(matrixWithBigSpaces!.size.columns, 4)
        
        let stringWithExtraNewLineCharacter = """
        1 2 3

        1 2 3
        1 2 3
        """
        let matrixWithExtraNewLineCharacter = Matrix<Int>(stringWithExtraNewLineCharacter)
        
        XCTAssertNotNil(matrixWithExtraNewLineCharacter)
        XCTAssertEqual(matrixWithExtraNewLineCharacter!.size.rows, 3)
        XCTAssertEqual(matrixWithExtraNewLineCharacter!.size.columns, 3)
    }
    
    func testDescription() {
        let matrix = Matrix<Int>(array: [
            [123, -43432, 4, 232222222321],
            [2, 23, 213213, 44],
            [23232123, 3, 232323, -43323]
        ])!
        let string = " 123        -43432     4         232222222321   \n 2           23        213213    44             \n 23232123    3         232323   -43323          "

        XCTAssertEqual(matrix.description, string)
    }
}
