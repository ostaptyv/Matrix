//
//  MatrixTests.swift
//  MatrixTests
//
//  Created by user149331 on 5/22/19.
//  Copyright © 2019 Ostap. All rights reserved.
//

import XCTest
@testable import Matrix

class MatrixTests: XCTestCase {
    
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
    
    func testStringInit() {
        let emptyString = ""
        let emptyMatrix = Matrix<Int>(string: emptyString)
        
        XCTAssertNil(emptyMatrix)
        
        let spoiledString = """
        1 2 3 4
        1 3   4
        """
        let spoiledMatrix = Matrix<Int>(string: spoiledString)
        
        XCTAssertNil(spoiledMatrix)
        
        let foreignCharacters = """
        1 2 g 4
        1 2m msq4
        """
        let matrixWithForeignCharaters = Matrix<Int>(string: foreignCharacters)
        
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
        let matrixWithInvalidForm1 = Matrix<Int>(string: invalidForm1)
        let matrixWithInvalidForm2 = Matrix<Double>(string: invalidForm2)
        
        XCTAssertNil(matrixWithInvalidForm1)
        XCTAssertNil(matrixWithInvalidForm2)
        
        let correctString = """
        1 2 3 5 6 4
        1 4 3 4 5 6
        """
        let matrix = Matrix<Int>(string: correctString)
        
        XCTAssertNotNil(matrix)
        XCTAssertEqual(matrix!.size.rows, 2)
        XCTAssertEqual(matrix!.size.columns, 6)
        
        let stringWithBigSpaces = """
           1 2 3    4
        1  3 5  3
         42  4 4 4
        """
        let matrixWithBigSpaces = Matrix<Int>(string: stringWithBigSpaces)
        
        XCTAssertNotNil(matrixWithBigSpaces)
        XCTAssertEqual(matrixWithBigSpaces!.size.rows, 3)
        XCTAssertEqual(matrixWithBigSpaces!.size.columns, 4)
        
        let stringWithExtraNewLineCharacter = """
        1 2 3

        1 2 3
        1 2 3
        """
        let matrixWithExtraNewLineCharacter = Matrix<Int>(string: stringWithExtraNewLineCharacter)
        
        XCTAssertNotNil(matrixWithExtraNewLineCharacter)
        XCTAssertEqual(matrixWithExtraNewLineCharacter!.size.rows, 3)
        XCTAssertEqual(matrixWithExtraNewLineCharacter!.size.columns, 3)
    }
    
    func testIdentityMatrixInit() {
        let stringIdentity = """
        1 0 0 0 0
        0 1 0 0 0
        0 0 1 0 0
        0 0 0 1 0
        0 0 0 0 1
        """
        let matrixIdentity = Matrix<Int>(string: stringIdentity)
        
        XCTAssertEqual(Matrix<Int>(identityMatrixOfOrder: 5), matrixIdentity)
    }
    
    func testZeroMatrixInit() {
        let string1 = """
        0 0 0
        0 0 0
        0 0 0
        """
        let string2 = """
        0.0 0.0 0.0 0.0 0.0 0.0 0.0
        0.0 0.0 0.0 0.0 0.0 0.0 0.0
        0.0 0.0 0.0 0.0 0.0 0.0 0.0
        0.0 0.0 0.0 0.0 0.0 0.0 0.0
        """
        
        let matrix1 = Matrix<Int>(zeroMatrixOfSize: (3, 3))
        let matrix2 = Matrix<Double>(zeroMatrixOfSize: (4, 7))
        let result1 = Matrix<Int>(string: string1)
        let result2 = Matrix<Double>(string: string2)
                
        XCTAssertEqual(matrix1, result1)
        XCTAssertEqual(matrix2, result2)
    }
    
    func testIsSquare() {
        let matrix1 = Matrix<Int>(zeroMatrixOfSize: (3, 3))
        let matrix2 = Matrix<Double>(zeroMatrixOfSize: (4, 7))
        
        XCTAssertTrue(matrix1.isSquare)
        XCTAssertFalse(matrix2.isSquare)
    }
    
    func testEqualOperator() {
        let string1 = """
        1 2 3
        4 5 6
        7 8 9
        """
        let matrix1 = Matrix<Int>(string: string1)
        let matrix2 = Matrix<Int>(string: string1)
        
        XCTAssertTrue(matrix1 == matrix2)
        XCTAssertTrue(matrix2 == matrix1)
        
        let string2 = """
        9 8 7
        6 5 4
        3 2 1
        """
        let matrix3 = Matrix<Int>(string: string2)
        
        XCTAssertFalse(matrix1 == matrix3)
        XCTAssertFalse(matrix3 == matrix1)
    }
    
    func testPlusOperator() {
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
        
        let matrix1 = Matrix<Int>(string: string1)!
        let matrix2 = Matrix<Int>(string: string2)!
        let matrixResult = Matrix<Int>(string: stringResult)!
        
        XCTAssertEqual(matrix1 + matrix2, matrixResult)
        XCTAssertEqual(matrix2 + matrix1, matrixResult)
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
        
        var matrix1 = Matrix<Int>(string: string1)!
        let matrix2 = Matrix<Int>(string: string2)!
        let matrixResult = Matrix<Int>(string: stringResult)!
        
        matrix1 += matrix2
        
        XCTAssertEqual(matrix1, matrixResult)
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
        
        let matrix1 = Matrix<Int>(string: string1)!
        let matrix2 = Matrix<Int>(string: string2)!
        let matrixDistraction1from2 = Matrix<Int>(string: resultDistraction1from2)
        let matrixDistraction2from1 = Matrix<Int>(string: resultDistraction2from1)
        
        XCTAssertEqual(matrix1 - matrix2, matrixDistraction1from2)
        XCTAssertEqual(matrix2 - matrix1, matrixDistraction2from1)
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
        
        var matrix1 = Matrix<Int>(string: string1)!
        let matrix2 = Matrix<Int>(string: string2)!
        let matrixDistraction1from2 = Matrix<Int>(string: resultDistraction1from2)
        
        matrix1 -= matrix2
        
        XCTAssertEqual(matrix1, matrixDistraction1from2)
    }
    
    func testSubscript() {
        let matrix = Matrix<Int>(string: """
        11 12 13 14 15
        21 22 23 24 25
        31 32 33 34 35
        """)!
        
        XCTAssertEqual(matrix[1, 0], 21)
        XCTAssertEqual(matrix[2, 4], 35)
        XCTAssertEqual(matrix[3, 5], 0)
        XCTAssertEqual(matrix[-1, 4], 0)
        XCTAssertEqual(matrix[2, 7], 0)
    }
    
    func testDescription() {
        let matrix = Matrix<Int>(array: [
            [123, -43432, 4, 232222222321],
            [2, 23, 213213, 44],
            [23232123, 3, 232323, -43323]
        ])!
        print(matrix.description)
        let string = " 123        -43432     4         232222222321   \n 2           23        213213    44             \n 23232123    3         232323   -43323          "

        XCTAssertEqual(matrix.description, string)
    }
    
    func testAcceptabilityInitializationWithDescriptionProperty() {
        let matrix1 = Matrix<Int>(array: [
            [1233, 33, 3],
            [21, 44, 4],
            [21, -443, 211],
            [-232, 21, 232]
        ])!

        let matrix2 = Matrix<Int>(string: matrix1.description)
        
        XCTAssertEqual(matrix1, matrix2)
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
        
        let inputMatrix1 = Matrix<Int>(string: inputString1)!
        let originalMatrix1 = Matrix<Int>(string: inputString1)!
        let resultMatrix1 = Matrix<Int>(string: resultString1)!

        let transposedMatrix1 = inputMatrix1.transposed()

        XCTAssertEqual(transposedMatrix1, resultMatrix1)
        XCTAssertEqual(inputMatrix1, originalMatrix1)
        
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
        
        let inputMatrix2 = Matrix<Int>(string: inputString2)!
        let originalMatrix2 = Matrix<Int>(string: inputString2)!
        let resultMatrix2 = Matrix<Int>(string: resultString2)!

        let transposedMatrix2 = inputMatrix2.transposed()
        
        XCTAssertEqual(transposedMatrix2, resultMatrix2)
        XCTAssertEqual(inputMatrix2, originalMatrix2)
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
        
        let inputMatrix1 = Matrix<Int>(string: inputString1)!
        let resultMatrix1 = Matrix<Int>(string: resultString1)!
        
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
        
        let inputMatrix2 = Matrix<Int>(string: inputString2)!
        let resultMatrix2 = Matrix<Int>(string: resultString2)!
        
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
        let matrix = Matrix<Int>(string: string)!
        
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
        
        let matrix1 = Matrix<Int>(string: string1)!
        let matrix2 = Matrix<Int>(string: string2)!
        let resultMatrix = Matrix<Int>(string: resultString)!
        
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
        
        let matrix = Matrix<Int>(string: string)!
        let resultMatrix = Matrix<Int>(string: result)!
        
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
        
        var matrix = Matrix<Int>(string: string)!
        let resultMatrix = Matrix<Int>(string: result)!
        
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
        
        let matrix = Matrix<Int>(string: string)!
        let resultMatrix = Matrix<Int>(string: result)!

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
        
        let matrix = Matrix<Int>(string: string)!
        let resultMatrix1 = Matrix<Int>(string: result1)!
        let resultMatrix2 = Matrix<Int>(string: result2)!

        XCTAssertEqual(matrix.makeMatrixChoosing(rows: [1, 2], columns: [3, 0, 2]), resultMatrix1)
        XCTAssertEqual(matrix.makeMatrixChoosing(rows: [2, 0], columns: [0, 3]), resultMatrix2)
        XCTAssertNil(matrix.makeMatrixChoosing(rows: [0, 3], columns: [0, 4])) //out of range test
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
        
        let matrix = Matrix<Int>(string: string)!
        let resultMatrix1 = Matrix<Int>(string: result1)!
        let resultMatrix2 = Matrix<Int>(string: result2)!
        let resultMatrix3 = Matrix<Int>(string: result3)!

        XCTAssertEqual(matrix.makeMatrixRemoving(rows: [0], columns: [1]), resultMatrix1)
        XCTAssertEqual(matrix.makeMatrixRemoving(rows: [3, 1], columns: [1, 3]), resultMatrix2)
        XCTAssertEqual(matrix.makeMatrixRemoving(rows: [3, 1, 2], columns: [1, 3, 2]), resultMatrix3)
        XCTAssertNil(matrix.makeMatrixRemoving(rows: [0, 5], columns: [0, 5])) // out of range
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
        
        let matrixInt1 = Matrix<Int>(string: stringInt1)!
        let matrixInt2 = Matrix<Int>(string: stringInt2)!
        let matrixDouble = Matrix<Double>(string: stringDouble)!
        let nonSquareMatrix = Matrix<Int>(string: nonSquare)!
        
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
        
        let nonDegenerateMatrix = Matrix<Int>(string: nonDegenerate)!
        let degenerateMatrix = Matrix<Int>(string: degenerate)!
        
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
        
        let symmetricMatrix = Matrix<Int>(string: symmetric)!
        let nonSymmetricMatrix = Matrix<Int>(string: nonSymmetric)!
        let nonSquareMatrix = Matrix<Int>(string: nonSquare)!
        
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
        
        let antisymmetricMatrix = Matrix<Int>(string: antisymmetric)!
        let nonAntisymmetricMatrix = Matrix<Int>(string: nonAntisymmetric)!
        let nonSquareMatrix = Matrix<Int>(string: nonSquare)!

        XCTAssertTrue(antisymmetricMatrix.isAntisymmetric)
        XCTAssertFalse(nonAntisymmetricMatrix.isAntisymmetric)
        XCTAssertFalse(nonSquareMatrix.isAntisymmetric)
    }
}
