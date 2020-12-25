//
//  MatrixTests.swift
//  MatrixTests
//
//  Created by Ostap Tyvonovych on 5/22/19.
//  Copyright © 2019 OstapTyvonovych. All rights reserved.
//

import XCTest
@testable import Matrix

class MainTestSuite: XCTestCase {
    
    func testIdentityMatrixInit() {
        let stringIdentity = """
        1 0 0 0 0
        0 1 0 0 0
        0 0 1 0 0
        0 0 0 1 0
        0 0 0 0 1
        """
        let matrixIdentity = Matrix<Int>(stringIdentity)
        
        XCTAssertEqual(Matrix<Int>(identityMatrixOfOrder: 5), matrixIdentity)
    }
    
    func testZeroMatrixInit() {
        let stringInt = """
        0 0 0
        0 0 0
        0 0 0
        """
        let stringDouble = """
        0.0 0.0 0.0 0.0 0.0 0.0 0.0
        0.0 0.0 0.0 0.0 0.0 0.0 0.0
        0.0 0.0 0.0 0.0 0.0 0.0 0.0
        0.0 0.0 0.0 0.0 0.0 0.0 0.0
        """
        let resultInt = Matrix<Int>(stringInt)
        let resultDouble = Matrix<Double>(stringDouble)
        
        let matrixInt = Matrix<Int>(zeroMatrixOfSize: (3, 3))
        let matrixDouble = Matrix<Double>(zeroMatrixOfSize: (4, 7))
                
        XCTAssertEqual(matrixInt, resultInt)
        XCTAssertEqual(matrixDouble, resultDouble)
    }
    
    func testIsSquare() {
        let stringSquare = """
        0 0 0 0
        0 0 0 0
        0 0 0 0
        0 0 0 0
        """
        let stringNonSquare = """
        0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0
        0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0
        0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0
        """
        let matrixSquare = Matrix<Int>(stringSquare)!
        let matrixNonSquare = Matrix<Double>(stringNonSquare)!
        
        XCTAssertTrue(matrixSquare.isSquare)
        XCTAssertFalse(matrixNonSquare.isSquare)
    }
    
    func testEqualOperator() {
        let string1 = """
        1 2 3
        4 5 6
        7 8 9
        """
        let matrix1 = Matrix<Int>(string1)
        let matrix2 = Matrix<Int>(string1) // we can use the same string since the string will be copied (String is a struct and has value type behavior)
        
        XCTAssertTrue(matrix1 == matrix2)
        XCTAssertTrue(matrix2 == matrix1)
        
        let string2 = """
        9 8 7
        6 5 4
        3 2 1
        """
        let matrix3 = Matrix<Int>(string2)
        
        XCTAssertFalse(matrix1 == matrix3)
        XCTAssertFalse(matrix3 == matrix1)
    }
    
    let zeroMatrix = Matrix<Int>("0")!
    
    func testPlusOperator() {
        let string1 = """
         1 8 3
        -4 5 6
        -7 8 2
        """
        let string2 = """
        9 -8 7
        6 13 4
        3  2 1
        """
        let stringResult = """
        10 0 10
        2 18 10
        -4 10 3
        """
        let stringDifferentSize = """
        12 43  2  4
         1 -4 98  6
        """
        
        let matrix1 = Matrix<Int>(string1)!
        let matrix2 = Matrix<Int>(string2)!
        let matrixResult = Matrix<Int>(stringResult)!
        
        XCTAssertEqual(matrix1 + matrix2, matrixResult)
        XCTAssertEqual(matrix2 + matrix1, matrixResult)
        
        let matrixDifferentSize = Matrix<Int>(stringDifferentSize)!
        
        XCTAssertEqual(matrix1 + matrixDifferentSize, zeroMatrix)
        XCTAssertEqual(matrixDifferentSize + matrix1, zeroMatrix)
    }
    
    func testPlusEqualOperator() {
        let string1 = """
        1 8 3
        -4 5 6
        -7 8 2
        """
        let string2 = """
        9 -8 7
        6 13 4
        3 2 1
        """
        let stringResult = """
        10 0 10
        2 18 10
        -4 10 3
        """
        let stringDifferentSize = """
        1
        6
        4
        """
        
        var matrix1 = Matrix<Int>(string1)!
        let matrix2 = Matrix<Int>(string2)!
        let matrixResult = Matrix<Int>(stringResult)!
        
        matrix1 += matrix2
        
        XCTAssertEqual(matrix1, matrixResult)
        
        let matrixDifferentSize = Matrix<Int>(stringDifferentSize)!
        
        matrix1 += matrixDifferentSize
        
        XCTAssertEqual(matrix1, zeroMatrix)
    }
    
    func testInfixMinusOperator() {
        let string1 = """
        1 8 3
        -4 5 6
        -7 8 2
        """
        let string2 = """
        9 -8 7
        6 13 4
        3 2 1
        """
        let resultDistraction1from2 = """
        -8 16 -4
        -10 -8 2
        -10 6 1
        """
        let resultDistraction2from1 = """
        8 -16 4
        10 8 -2
        10 -6 -1
        """
        let stringDifferentSize = """
        12 34 51
        """
        let matrix1 = Matrix<Int>(string1)!
        let matrix2 = Matrix<Int>(string2)!
        let matrixDistraction1from2 = Matrix<Int>(resultDistraction1from2)
        let matrixDistraction2from1 = Matrix<Int>(resultDistraction2from1)
        
        XCTAssertEqual(matrix1 - matrix2, matrixDistraction1from2)
        XCTAssertEqual(matrix2 - matrix1, matrixDistraction2from1)
        
        let matrixDifferentSize = Matrix<Int>(stringDifferentSize)!
        
        XCTAssertEqual(matrix1 - matrixDifferentSize, zeroMatrix)
        XCTAssertEqual(matrixDifferentSize - matrix1, zeroMatrix)
    }
    
    func testMinusEqualOperator() {
        let string1 = """
        1 8 3
        -4 5 6
        -7 8 2
        """
        let string2 = """
        9 -8 7
        6 13 4
        3 2 1
        """
        let resultDistraction1from2 = """
        -8 16 -4
        -10 -8 2
        -10 6 1
        """
        let stringDifferentSize = """
        12 5
        """
        var matrix1 = Matrix<Int>(string1)!
        let matrix2 = Matrix<Int>(string2)!
        let matrixDistraction1from2 = Matrix<Int>(resultDistraction1from2)
        
        matrix1 -= matrix2
        
        XCTAssertEqual(matrix1, matrixDistraction1from2)
        
        let matrixDifferentSize = Matrix<Int>(stringDifferentSize)!
        
        matrix1 -= matrixDifferentSize
        
        XCTAssertEqual(matrix1, zeroMatrix)
    }
    
    func testSubscript() {
        var matrix = Matrix<Int>("""
        11 12 13 14 15
        21 22 23 24 25
        31 32 33 34 35
        """)!
        
        XCTAssertEqual(matrix[1, 0], 21)
        XCTAssertEqual(matrix[2, 4], 35)
        XCTAssertEqual(matrix[3, 5], 0)
        XCTAssertEqual(matrix[-1, 4], 0)
        XCTAssertEqual(matrix[2, 7], 0)
        
        let mutatedMatrix = Matrix<Int>("""
        41 12 13 14 45
        21 22 100 24 25
        91 32 33 34 59
        """)!
        
        matrix[0, 0] = 41
        matrix[0, 4] = 45
        matrix[2, 0] = 91
        matrix[2, 4] = 59
        matrix[1, 2] = 100
        
        // Will have no effect
        matrix[5, 5] = 9299
        matrix[-1, -3] = 2
        matrix[100, 1] = 13
        matrix[1, 100] = 31
        
        XCTAssertEqual(matrix, mutatedMatrix)
    }
    
    func testAcceptabilityInitializationWithDescriptionProperty() {
        let matrix = Matrix<Int>(array: [
            [1233, 33, 3],
            [21, 44, 4],
            [21, -443, 211],
            [-232, 21, 232]
        ])!

        let sameMatrix = Matrix<Int>(matrix.description)
        
        XCTAssertEqual(matrix, sameMatrix)
    }
    
    func testTransposed() {
        let inputString1 = """
        12 65 3
        29 40 22
        33 76 99
        """
        let resultString1 = """
        12 29 33
        65 40 76
        3  22 99
        """
        let inputMatrix1 = Matrix<Int>(inputString1)!
        let originalMatrix1 = Matrix<Int>(inputString1)!
        let resultMatrix1 = Matrix<Int>(resultString1)!

        let transposedMatrix1 = inputMatrix1.transposed()

        XCTAssertEqual(transposedMatrix1, resultMatrix1)
        XCTAssertEqual(inputMatrix1, originalMatrix1) // non-mutating test
        
        let inputString2 = """
        12 65 3
        29 40 22
        33 76 99
        123 0 2
        """
        let resultString2 = """
        12 29 33 123
        65 40 76 0
        3  22 99 2
        """
        let inputMatrix2 = Matrix<Int>(inputString2)!
        let originalMatrix2 = Matrix<Int>(inputString2)!
        let resultMatrix2 = Matrix<Int>(resultString2)!

        let transposedMatrix2 = inputMatrix2.transposed()
        
        XCTAssertEqual(transposedMatrix2, resultMatrix2)
        XCTAssertEqual(inputMatrix2, originalMatrix2) // non-mutating test
        XCTAssertEqual(transposedMatrix2.size.rows, 3)
        XCTAssertEqual(transposedMatrix2.size.columns, 4)
    }
    
    func testTranspose() {
        let inputString1 = """
        12 65 3
        29 40 22
        33 76 99
        """
        let resultString1 = """
        12 29 33
        65 40 76
        3  22 99
        """
        var inputMatrix1 = Matrix<Int>(inputString1)!
        let resultMatrix1 = Matrix<Int>(resultString1)!
        
        inputMatrix1.transpose()
        
        XCTAssertEqual(inputMatrix1, resultMatrix1)
        
        let inputString2 = """
        12 65 3 5
        29 40 22 678
        33 76 99 33
        """
        let resultString2 = """
        12 29 33
        65 40 76
        3  22 99
        5 678 33
        """
        var inputMatrix2 = Matrix<Int>(inputString2)!
        let resultMatrix2 = Matrix<Int>(resultString2)!
        
        inputMatrix2.transpose()
        
        XCTAssertEqual(inputMatrix2, resultMatrix2)
        XCTAssertEqual(inputMatrix2.size.rows, 4)
        XCTAssertEqual(inputMatrix2.size.columns, 3)
    }
    
    func testIsTransposed() {
        let string = """
        12 65 3
        29 40 22
        33 76 99
        """
        var matrix = Matrix<Int>(string)!
        
        XCTAssertFalse(matrix.isTransposed)
        matrix.transpose()
        XCTAssertTrue(matrix.isTransposed)
        matrix.transpose()
        XCTAssertFalse(matrix.isTransposed)
    }
    
    func testMultiplyOperator() {
        let string1 = """
        1 3 -5 4
        3 2 7 6
        -8 4 5 2
        """
        let string2 = """
        2 5
        3 1
        2 8
        -9 3
        """
        let resultString = """
        -35 -20
        -28 91
        -12 10
        """
        let matrix1 = Matrix<Int>(string1)!
        let matrix2 = Matrix<Int>(string2)!
        let resultMatrix = Matrix<Int>(resultString)!
        
        XCTAssertEqual(matrix1 * matrix2, resultMatrix)
        XCTAssertNotEqual(matrix2 * matrix1, resultMatrix)
    }
    
    func testMultiplyScalarNumberOnMatrixOperator() {
        let string = """
        1 3 2
        5 0 2
        """
        let result = """
        5 15 10
        25 0 10
        """
        let matrix = Matrix<Int>(string)!
        let resultMatrix = Matrix<Int>(result)!
        
        XCTAssertEqual(matrix * 5, resultMatrix)
        XCTAssertEqual(5 * matrix, resultMatrix)
    }
    
    func testMultiplyEqualScalarNumberOnMatrixOperator() {
        let string = """
        1 3 2
        5 0 2
        """
        let result = """
        5 15 10
        25 0 10
        """
        var matrix = Matrix<Int>(string)!
        let resultMatrix = Matrix<Int>(result)!
        
        matrix *= 5
        
        XCTAssertEqual(matrix, resultMatrix)
    }
    
    func testPrefixMinusOperator() {
        let string = """
        1 3 -5 4
        3 2 7 6
        -8 4 5 2
        """
        let result = """
        -1 -3 5 -4
        -3 -2 -7 -6
        8 -4 -5 -2
        """
        let matrix = Matrix<Int>(string)!
        let resultMatrix = Matrix<Int>(result)!

        XCTAssertEqual(-matrix, resultMatrix)
    }
    
    func testMakeMatrixChoosingRowsAndColumns() {
        let string = """
        1 3 -5 4
        3 2 7 6
        -8 4 5 2
        """
        let result1 = """
        3 7 6
        -8 5 2
        """
        let result2 = """
        1 4
        -8 2
        """
        let matrix = Matrix<Int>(string)!
        let resultMatrix1 = Matrix<Int>(result1)!
        let resultMatrix2 = Matrix<Int>(result2)!

        XCTAssertEqual(matrix.makeMatrixChoosing(rows: [1, 2], columns: [3, 0, 2]), resultMatrix1)
        XCTAssertEqual(matrix.makeMatrixChoosing(rows: [2, 0], columns: [0, 3]), resultMatrix2)
        
        // Edge cases
        XCTAssertNil(matrix.makeMatrixChoosing(rows: [], columns: [1, 3]))
        XCTAssertNil(matrix.makeMatrixChoosing(rows: [0, 1], columns: []))
        
        XCTAssertNil(matrix.makeMatrixChoosing(rows: [0, 1], columns: [0, 4]))
        XCTAssertNil(matrix.makeMatrixChoosing(rows: [0, 3], columns: [0, 2]))
    }
    
    func testMakeMatrixCrosingOffRowsAndColumns() {
        let string = """
        1 2 3 4 5
        6 7 8 9 10
        11 12 13 14 15
        16 17 18 19 20
        21 22 23 24 25
        """
        let result1 = """
        6 8 9 10
        11 13 14 15
        16 18 19 20
        21 23 24 25
        """
        let result2 = """
        1 3 5
        11 13 15
        21 23 25
        """
        let result3 = """
        1 5
        21 25
        """
        let matrix = Matrix<Int>(string)!
        let resultMatrix1 = Matrix<Int>(result1)!
        let resultMatrix2 = Matrix<Int>(result2)!
        let resultMatrix3 = Matrix<Int>(result3)!

        XCTAssertEqual(matrix.makeMatrixRemoving(rows: [0], columns: [1]), resultMatrix1)
        XCTAssertEqual(matrix.makeMatrixRemoving(rows: [3, 1], columns: [1, 3]), resultMatrix2)
        XCTAssertEqual(matrix.makeMatrixRemoving(rows: [3, 1, 2], columns: [1, 3, 2]), resultMatrix3)
        
        // Edge cases
        XCTAssertNil(matrix.makeMatrixRemoving(rows: [0, 5], columns: [0, 2]))
        XCTAssertNil(matrix.makeMatrixRemoving(rows: [0, 1, 2], columns: [0, 6]))
        
        XCTAssertNil(matrix.makeMatrixRemoving(rows: [], columns: [0, 2]))
        XCTAssertNil(matrix.makeMatrixRemoving(rows: [0, 1, 2], columns: []))
    }
    
    func testDeterminant() {
        let stringInt1 = """
        2 -5 4 3
        3 -4 7 5
        4 -9 8 5
        -3 2 -5 3
        """
        let stringDouble = """
        2.0 -5.0 4.0 3.0
        3.0 -4.0 7.0 5.0
        4.0 -9.0 8.0 5.0
        -3.0 2.0 -5.0  3.0
        """
        let stringInt2 = """
        2 -5 4 3 3 4 6
        3 -4 7 5 2 1 4
        4 -9 8 5 4 2 3
        -3 2 -5 3 32 4 5
        12 4 5 4 4 32 7
        8 3 0 5 1 8 4
        3 2 4 5 6 1 0
        """
        let nonSquare = """
        1 2 3
        4 5 6
        """
        let matrixInt1 = Matrix<Int>(stringInt1)!
        let matrixInt2 = Matrix<Int>(stringInt2)!
        let matrixDouble = Matrix<Double>(stringDouble)!
        let nonSquareMatrix = Matrix<Int>(nonSquare)!
        
        XCTAssertEqual(matrixInt1.determinant(), 4)
        XCTAssertEqual(matrixInt2.determinant(), 327188)
        XCTAssertEqual(matrixDouble.determinant(), 4.0)
        XCTAssertNil(nonSquareMatrix.determinant())
    }
    
    func testIsDegenerate() {
        let nonDegenerate = """
        2 -5 4 3
        3 -4 7 5
        4 -9 8 5
        -3 2 -5 3
        """
        let degenerate = """
        1 2 3
        1 2 3
        4 7 8
        """
        let nonDegenerateMatrix = Matrix<Int>(nonDegenerate)!
        let degenerateMatrix = Matrix<Int>(degenerate)!
        
        XCTAssertFalse(nonDegenerateMatrix.isDegenerate)
        XCTAssertTrue(degenerateMatrix.isDegenerate)
    }
    
    func testIsSymmetric() {
        let symmetric = """
        1 7 4 6
        7 3 0 4
        4 0 2 5
        6 4 5 9
        """
        let nonSymmetric = """
        1 5 3 8
        4 3 6 8
        1 5 4 7
        3 8 2 8
        """
        let nonSquare = """
        1 2 3 4
        3 2 4 5
        1 2 3 5
        """
        let symmetricMatrix = Matrix<Int>(symmetric)!
        let nonSymmetricMatrix = Matrix<Int>(nonSymmetric)!
        let nonSquareMatrix = Matrix<Int>(nonSquare)!
        
        XCTAssertTrue(symmetricMatrix.isSymmetric)
        XCTAssertFalse(nonSymmetricMatrix.isSymmetric)
        XCTAssertFalse(nonSquareMatrix.isSymmetric)
    }
    
    func testIsAntisymmetric() {
        let antisymmetric = """
         0  -7  -4   6
         7   0   1  -4
         4  -1   0   5
        -6   4  -5   0
        """
        let nonAntisymmetric = """
        1 5 3 8
        4 3 6 8
        1 5 4 7
        3 8 2 8
        """
        let nonSquare = """
        1 2 3 4
        3 2 4 5
        1 2 3 5
        """
        let antisymmetricMatrix = Matrix<Int>(antisymmetric)!
        let nonAntisymmetricMatrix = Matrix<Int>(nonAntisymmetric)!
        let nonSquareMatrix = Matrix<Int>(nonSquare)!

        XCTAssertTrue(antisymmetricMatrix.isAntisymmetric)
        XCTAssertFalse(nonAntisymmetricMatrix.isAntisymmetric)
        XCTAssertFalse(nonSquareMatrix.isAntisymmetric)
    }
}
