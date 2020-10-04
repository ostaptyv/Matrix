//
//  Matrix.swift
//  Matrix
//
//  Created by Ostap Tyvonovych on 4/14/19.
//  Copyright © 2019 OstapTyvonovych. All rights reserved.
//

public typealias MatrixSize = (rows: Int, columns: Int)

public struct Matrix<Element: Arithmetic & Descriptionable>: Equatable {
    
    private var matrix: [[Element]]
    private var _size: MatrixSize
    private var _isTransposed = false
    
    private let stringDescriptionService = StringDescriptionService<Element>()
    
    // MARK: - Property of a matrix binded with its size
    
    /**
     The size of the matrix

         let array = [
         [12, 43, 87],
         [75, 40, 8]
         ]
         let matrix = Matrix<Int>(array: array)!
         
         print(matrix.size)
         
         // Prints "(rows: 2, columns: 3)"
     
    */
    public var size: MatrixSize {
        return _size
    }

    /**
     A Boolean value indicating whether the matrix is square.
     
         let nonSquare = """
         1 2 3 4
         5 3 0 7
         """
         let square = """
         1 4 3
         7 5 4
         3 8 5
         """
         let nonSquareMatrix = Matrix<Int>(string: nonSquare)!
         let squareMatrix = Matrix<Int>(string: square)!
         
         print(nonSquareMatrix.isSquare)
         print(squareMatrix.isSquare)
         
         // false
         // true
    */
    public var isSquare: Bool {
        return size.rows == size.columns
    }
    
    // MARK: - Subscripts
    
    public subscript(_ row: Int, _ column: Int) -> Element {
        get {
            guard row >= 0 && row < size.rows else {
                print("Subscript: Row index out of range")
                return Element.zero
            }
            guard column >= 0 && column < size.columns else {
                print("Subscript: Column index out of range")
                return Element.zero
            }
            
            return matrix[row][column]
        }
        set {
            guard row >= 0 && row < size.rows else {
                print("Subscript: Row index out of range")
                return
            }
            guard column >= 0 && column < size.columns else {
                print("Subscript: Column index out of range")
                return
            }
            
            matrix[row][column] = newValue
        }
    }
      
    // MARK: - Initializers
    
    /**
     Creates a matrix from an array of same-length arrays.
     
     Basically we pass to initializer array of matrix's rows, so it's important for all nested arrays have same quantity of elements. Otherwise init will return nil.
     
         let spoiledArray = [
         [1, 2, 3],
         [3, 5, 6],
         [2, 1]
         ]
         let spoiledMatrix = Matrix<Int>(array: spoiledArray)
     
         print(spoiledMatrix)
     
         // Prints "nil"
     
     If everything went well, init will return a matrix where count of elements in all nested arrays will be a number of *columns* and count of nested arrays in main array will be number of *rows*.
     
         let array = [
         [1, 4, 2, 3],
         [8, 0, 0, 1],
         [-6, -10, 4, 7]
         ]
         let matrix = Matrix<Int>(array: array)!
     
         print("Number of rows: \(matrix.size.rows)")
         print("Number of columns: \(matrix.size.columns)")
     
         // Number of rows: 3
         // Number of columns: 4
     
     - Parameters:
         - arrayOfRows: Array where count of elements in all nested arrays will be a number of *columns* and count of nested arrays in main array will be number of *rows*.
    */
    public init?(array arrayOfRows: [[Element]]) {
        if arrayOfRows.isEmpty {
            print("Array passed to init is empty")
            return nil
        }
        for i in 0..<arrayOfRows.count - 1 {
            let isRowsHaveDifferentSize = arrayOfRows[i].count != arrayOfRows[i+1].count
            if isRowsHaveDifferentSize {
                print("Different size of rows")
                return nil
            }
        }
        
        _size.rows = arrayOfRows.count
        _size.columns = arrayOfRows[0].count
        matrix = arrayOfRows
    }
    
    /**
     Creates a matrix from a given string.
     
     It doesn't matter how do you make your string literal, but we recommend to use multi-line string literal (""") for easier operating with matrices' strings:
     
         let correctString = """
         1 2 3
         1 4 2
         5 2 3
         """
         let matrix = Matrix<Int>(string: correctString)
     
         let alsoCorrectString = "1 2 3\n1 4 2\n5 2 3"
         let sameMatrix = Matrix<Int>(string: alsoCorrectString)
     
     It's important to comply with the rules of writing matrix form. If you'll miss one of the elements initialization fails:
     
         let spoiledString = """
         1 2 3 4
         1 3   4
         """
         let spoiledMatrix = Matrix<Int>(string: spoiledString)
     
         print(spoiledMatrix)
     
         // Prints "nil"
     
     You can only use symbols that are acceptable for initialization ("-", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "\n", "\t", " "). The last three symbols are used for separation. If init will get string with foreign characters it will return nil:
     
         let foreignCharacters = """
         1 2 g 4
         1 2m msq4
         """
         let matrixWithForeignCharaters = Matrix<Int>(string: foreignCharacters)
     
         print(matrixWithForeignCharaters)
     
         // Prints "nil"
     
     Even if you'll use acceptable characters but they will go in unexpected order initialization fails:
     
         let invalidForm1 = """
         -121 221 2
           12 3-2 1
         """
         let matrixWithInvalidForm1 = Matrix<Int>(string: invalidForm1)
     
         print(matrixWithInvalidForm1)
     
         // Prints "nil"
     
         let invalidForm2 = """
         0.0 2.1   5.2
         2.4 3.4   2.3
         1.0 7.8.4 3.0
         """
         let matrixWithInvalidForm2 = Matrix<Double>(string: invalidForm2)
     
         print(matrixWithInvalidForm2)
     
         // Prints "nil"
     
     You can use spaces, tabs and new line symbols of different sizes. It won't fail initialziation:
     
         let stringWithBigSpaces = """
         1 2 3    4
         1  3 5  3
         42  4 4 4
         """
         let matrixWithBigSpaces = Matrix<Int>(string: stringWithBigSpaces)!
     
         let stringWithBigTabs = """
         1 2\t\t\t3\t\t4
         1  \t 3\t5\t3
         42\t 4\t4 4\t\t
         """
         let matrixWithBigTabs = Matrix<Int>(string: stringWithBigTabs)!
     
         let stringWithExtraNewLineCharacters = """
         1 2 3
     
         1 2 3
         1 2 3
         """
         let matrixWithExtraNewLineCharacter = Matrix<Int>(string: stringWithExtraNewLineCharacter)
     
     String from the `description` property can be used for initializing another matrix:
     
         let matrix = Matrix<Int>(array: [[2, 5, 6, 3],
                                          [3, 2, 8, 6],
                                          [2, 0, 6, 4],
                                          [3, 8, 6, 7]])
     
         let anotherMatrix = Matrix<Int>(string: matrix.description)!
     
         print(anotherMatrix.size)
     
         // Prints "(rows: 4, columns: 4)"
     
     - Parameters:
         - string: A string containing matrix.
    */
    public init?(string: String) {
        let stringInitializerService = StringInitializerService<Element>()
        let convertedArray = stringInitializerService.convert(stringToMatrixArray: string)
        
        if let array = convertedArray {
            self.init(array: array)
        } else {
            return nil
        }
    }
    
    /**
     Creates a matrix where all elements are zeros.
     
         let matrix1 = Matrix<Int>(zeroMatrixOfSize: (3, 3))
         let matrix2 = Matrix<Double>(zeroMatrixOfSize: (4, 7))
     
         print("Zero matrix 3x3:\n" + matrix1.description)
         print("\nZero matrix 4x7\n" + matrix2.description)

         // Zero matrix 3x3:
         // 0 0 0
         // 0 0 0
         // 0 0 0
         // Zero matrix 4x7:
         // 0.0 0.0 0.0 0.0 0.0 0.0 0.0
         // 0.0 0.0 0.0 0.0 0.0 0.0 0.0
         // 0.0 0.0 0.0 0.0 0.0 0.0 0.0
         // 0.0 0.0 0.0 0.0 0.0 0.0 0.0
     
     - Parameters:
         - size: A tuple where the first element is number of rows and the second one is number of columns.
    */
    public init(zeroMatrixOfSize size: MatrixSize) {
        var array = [[Element]]()
        
        for _ in 0..<size.rows {
            var line = [Element]()
            for _ in 0..<size.columns {
                line.append(Element.zero)
            }
            array.append(line)
        }
        
        self.matrix = array
        self._size = size
    }
    
    /**
     Creates square matrix where diagonal elements are ones and other elements are zeros.
     
     As identity matrix must be square, you pass an order of your matrix to the initializer:
     
         let matrix = Matrix<Int>(identityMatrixOfOrder: 5)
         print("Identity matrix 5x5:\n" + matrix.description)
     
         // Identity matrix 5x5:
         // 1 0 0 0 0
         // 0 1 0 0 0
         // 0 0 1 0 0
         // 0 0 0 1 0
         // 0 0 0 0 1
     
     - Parameters:
         - order: Number of rows and columns in square matrix.
    */
    public init(identityMatrixOfOrder order: Int) {
        var array = [[Element]]()
        
        for i in 0..<order {
            var line = [Element]()
            for j in 0..<order {
                if i == j {
                    line.append(Element.one)
                } else {
                    line.append(Element.zero)
                }
            }
            array.append(line)
        }
        
        self.matrix = array
        self._size = (order, order)
    }
    
    // MARK: - Description
    
    /// A textual representation of this matrix.
    public var description: String {
        return stringDescriptionService.makeDescription(using: matrix, for: size)
    }
    
    // MARK: - 'Equatable' conformance
    
    public static func == (left: Matrix<Element>, right: Matrix<Element>) -> Bool {
        guard left.size == right.size else {
            print("Matrices have different size, therefore equality can't be checked; matrices must have same quantity of rows and columns")
            return false
        }
        
        var result = true
        
        mainLoop: for i in 0..<left.size.rows {
            for j in 0..<left.size.columns {
                if left[i, j] != right[i, j] {
                    result = false
                    break mainLoop
                }
            }
        }
        return result
    }
    
    // MARK: - Operations to be done with two matrices:
        
    // MARK: Addition operator
    
    public static func + (left: Matrix, right: Matrix) -> Matrix {
        guard left.size == right.size else {
            print("Matrixes have differenet size, therefore addition can't be applied; matrixes must have same quantity of rows and columns")
            return Matrix(zeroMatrixOfSize: (1, 1))
        }
        
        var result = Matrix(zeroMatrixOfSize: right.size)
        for i in 0..<left.size.rows {
            for j in 0..<left.size.columns {
                result[i, j] = left[i, j] + right[i, j]
            }
        }
        return result
    }
    
    public static func += (left: inout Matrix, right: Matrix) {
        left = left + right
    }
    
    // MARK: Subtraction operator
    
    public static func - (left: Matrix, right: Matrix) -> Matrix {
        guard left.size == right.size else {
            print("Matrixes have differenet size, therefore distraction can't be applied; matrixes must have same quantity of rows and columns")
            return Matrix(zeroMatrixOfSize: (1, 1))
        }
        
        var result = Matrix(zeroMatrixOfSize: left.size)
        for i in 0..<left.size.rows {
            for j in 0..<left.size.columns {
                result[i, j] = left[i, j] - right[i, j]
            }
        }
        return result
    }
    
    public static func -= (left: inout Matrix, right: Matrix) {
        left = left - right
    }
    
    // MARK: Multiplication operator
    
    public static func * (left: Matrix, right: Matrix) -> Matrix {
        guard left.size.columns == right.size.rows else {
            print("Matrices aren't coupled, therefore multiplication can't be applied; coupled are those matrices quantity of columns of the first one is equal to quantity of rows of the second one:\n A(m X n)*B(n X q) = C(m X q) ")
            return Matrix(zeroMatrixOfSize: (1, 1))
        }
        
        var result = Matrix<Element>(zeroMatrixOfSize: (left.size.rows, right.size.columns))
        
        for i in 0..<left.size.rows {
            for j in 0..<right.size.columns {
                var element = Element.zero
                for k in 0..<left.size.columns { // or 0..<right.size.rows, doesn't matter. They're equal by definition
                    element += left[i, k] * right[k, j]
                }
                result[i, j] = element
            }
        }
        
        return result
    }
    
    // MARK: - Operations to be done with matrix and some element:
    
    // MARK: Multiplication operator
    
    public static func * (left: Element, right: Matrix) -> Matrix {
        var result = Matrix<Element>(zeroMatrixOfSize: right.size)
        for i in 0..<right.size.rows {
            for j in 0..<right.size.columns {
                result[i, j] += right[i, j] * left
            }
        }
        return result
    }
    
    public static func * (left: Matrix, right: Element) -> Matrix {
        var result = Matrix<Element>(zeroMatrixOfSize: left.size)
        for i in 0..<left.size.rows {
            for j in 0..<left.size.columns {
                result[i, j] += left[i, j] * right
            }
        }
        return result
    }
    
    public static func *= (left: inout Matrix, right: Element) {
        for i in 0..<left.size.rows {
            for j in 0..<left.size.columns {
                left[i, j] = left[i, j] * right
            }
        }
    }
    
    // MARK: - Operation to be done with one matrix:
    
    // MARK: Prefix minus
    
    public static prefix func - (right: Matrix) -> Matrix {
        return -Element.one * right
    }
    
    // MARK: - Transposing of matrix
    
    /**
     Returns transposed towards current matrix.
     
         let inputString = """
         12 65 3
         29 40 22
         33 76 99
         """
     
         let inputMatrix = Matrix<Int>(string: inputString)!
         let transposedMatrix = inputMatrix.transposed()
     
         print(transposedMatrix.description)
     
         // 12    29    33
         // 65    40    76
         // 3     22    99
     
     You can also transpose non-square matrices:
     
         let inputString = """
         12 65 3
         29 40 22
         33 76 99
         123 0 2
         """
         let resultString = """
         12 29 33 123
         65 40 76 0
         3  22 99 2
         """
     
         let inputMatrix = Matrix<Int>(string: inputString)!
         let resultMatrix = Matrix<Int>(string: resultString)!
     
         let transposedMatrix = inputMatrix.transposed()
     
         if transposedMatrix == resultMatrix {
             print("Two matrices are equal")
         }
         print(transposedMatrix.size)
     
         // Prints:
         //
         // Two matrices are equal
         // (rows: 3, columns: 4)
     */
    public func transposed() -> Matrix {
        var result = Matrix<Element>(zeroMatrixOfSize: (size.columns, size.rows))
        for i in 0..<size.rows {
            for j in 0..<size.columns {
                result[j, i] = matrix[i][j]
            }
        }
        return result
        
    }
    
    /**
     Transposes matrix in place.
     
         let inputString = """
         12 65 3
         29 40 22
         33 76 99
         """
         let inputMatrix = Matrix<Int>(string: inputString)!
     
         inputMatrix.transpose()
     
         print(inputMatrix.description)
     
         // 12    29    33
         // 65    40    76
         // 3     22    99
     
     You can also transpose non-square matrices:
     
         let inputString = """
         12 65 3 5
         29 40 22 678
         33 76 99 33
         """
         let resultString = """
         12 29 33
         65 40 76
         3  22 99
         5 678 33
         """
     
         let matrix = Matrix<Int>(string: inputString)!
         let resultMatrix = Matrix<Int>(string: resultString)!
     
         matrix.transpose()
     
         if matrix == resultMatrix {
             print("Two matrices are equal")
         }
         print(matrix.size)
     
         // Prints:
         //
         // Two matrices are equal
         // (rows: 4, columns: 3)
    */
    public mutating func transpose() {
        let oldMatrix = matrix
        var newMatrix = [[Element]]()
        
        for j in 0..<size.columns {
            newMatrix.append([Element]())
            for i in 0..<size.rows {
                newMatrix[j].append(oldMatrix[i][j])
            }
        }
        
        matrix = newMatrix
        _size = (size.columns, size.rows)
        
        _isTransposed = !_isTransposed
    }
    
    /**
     A Boolean value indicating whether the matrix was transposed. Default value is `false`.
     
     The property indicates the state of current instance of the matrix. That means it doesn't change when `transposed()` method called:
     
         let matrix = Matrix<Int>(string: string)!
         print(matrix.isTransposed)
     
         let _ = matrix.transposed()
         print(matrix.isTransposed)
     
         matrix.transpose()
         print(matrix.isTransposed)
     
         // false
         // false
         // true
     
    */
    public var isTransposed: Bool {
        return _isTransposed
    }
    
    // MARK: - Manipulating with rows and columns
    
    /**
     Makes matrix from intersection of chosen rows and columns. Indices start from 0, 1, 2...
     
         let string = """
         1 3 -5 4
         3 2 7 6
         -8 4 5 2
         """
         let result = """
         3 7 6
         -8 5 2
         """
     
         let matrix = Matrix<Int>(string: string)!
         let resultMatrix = Matrix<Int>(string: result)!
     
         if matrix.makeMatrixChoosing(rows: [1, 2], columns: [0, 2, 3]) == resultMatrix {
             print("They are equal!")
         }
     
         // Prints "They are equal!"
     
     You can change order of numbers in your arrays:
     
         let someMatrix = matrix.makeMatrixChoosing(rows: [1, 2], columns: [0, 2, 3])
         let sameMatrix = matrix.makeMatrixChoosing(rows: [2, 1], columns: [3, 0, 2])
     
         if someMatrix == sameMatrix {
            print("They are the same")
         }
     
         // Prints "They are the same"
     
     If one of your indices will be bigger than amount of rows or columns in the matrix method returns *nil*:
     
         let outOfRange = matrix.makeMatrixChoosing(rows: [0, 3], columns: [0, 4]))
     
         print(outOfRange)
     
         // Prints:
         //
         // makeMatrixChoosing(rows:columns:): Row index out of range
         // nil
     
     - Parameters:
         - rows: Array of indices of chosen rows.
         - columns: Array of indices of chosen columns.
     
    */
    public func makeMatrixChoosing(rows: [Int], columns: [Int]) -> Matrix? {
        guard !rows.isEmpty && !columns.isEmpty else {
            print("Array of rows or/and columns are empty")
            return nil
        }
        
        let rows = [Int](Set<Int>(rows)).sorted()
        let columns = [Int](Set<Int>(columns)).sorted()
        
        for number in rows {
            guard number >= 0 && number < size.rows else {
                print("makeMatrixChoosing(rows:columns:): Row index out of range")
                return nil
            }
        }
        for number in columns {
            guard number >= 0 && number < size.columns else {
                print("makeMatrixChoosing(rows:columns:): Column index out of range")
                return nil
            }
        }
        
        var result = Matrix<Element>(zeroMatrixOfSize: (rows.count, columns.count))
        
        for i in 0..<rows.count {
            for j in 0..<columns.count {
                let chosenRow = rows[i]
                let chosenColumn = columns[j]
                result[i, j] = matrix[chosenRow][chosenColumn]
            }
        }
        
        return result
    }
    
    /**
     Makes matrix from elements that remainded after removing chosen rows and columns. Indices start from 0, 1, 2...
     
         let string = """
         1 2 3 4 5
         6 7 8 9 10
         11 12 13 14 15
         16 17 18 19 20
         21 22 23 24 25
         """
         let result = """
         6 8 9 10
         11 13 14 15
         16 18 19 20
         21 23 24 25
         """
     
         let matrix = Matrix<Int>(string: string)!
         let resultMatrix = Matrix<Int>(string: result)!
     
         if matrix.makeMatrixRemoving(rows: [0], columns: [1]) == resultMatrix {
             print("They are equal!")
         }
     
         // Prints "They are equal"
     
     You can change order of numbers in your arrays:
     
         let someMatrix = matrix.makeMatrixRemoving(rows: [1, 2, 4], columns: [0, 3])
         let sameMatrix = matrix.makeMatrixRemoving(rows: [2, 4, 1], columns: [3, 0])
     
         if someMatrix == sameMatrix {
             print("They are the same")
         }
     
         // Prints "They are the same"
     
     If one of your indices will be bigger than amount of rows or columns in the matrix method returns *nil*:
     
         let outOfRange = matrix.makeMatrixRemoving(rows: [0, 4], columns: [0, 5])
     
         print(outOfRange)
     
         // Prints:
         //
         // makeMatrixRemoving(rows:columns:): Column index out of range
         // nil
     
     - Parameters:
         - rows: Array of indices of rows to be removed.
         - columns: Array of indices of columns to be removed.
     */
    public func makeMatrixRemoving(rows: [Int], columns: [Int]) -> Matrix? {

        guard !rows.isEmpty && !columns.isEmpty else {
            print("Array of rows or/and columns are empty")
            return nil
        }
        
        let crossedOffRows = Set<Int>(rows)
        let crossedOffColumns = Set<Int>(columns)
        
        for number in crossedOffRows {
            guard number >= 0 && number < size.rows else {
                print("makeMatrixRemoving(rows:columns:): Row index out of range")
                return nil
            }
        }
        for number in crossedOffColumns {
            guard number >= 0 && number < size.columns else {
                print("makeMatrixRemoving(rows:columns:): Column index out of range")
                return nil
            }
        }
        
        let rangeOffAllPossibleRows = Set<Int>(0..<size.rows)
        let rangeOffAllPossibleColumns = Set<Int>(0..<size.columns)
        
        let chosenRows = rangeOffAllPossibleRows.subtracting(crossedOffRows).sorted()
        let chosenColumns = rangeOffAllPossibleColumns.subtracting(crossedOffColumns).sorted()
        
        return makeMatrixChoosing(rows: chosenRows, columns: chosenColumns)
    }
    
    // MARK: - Calculating a determinant
    
    /**
     Calculates a determinant of the matrix.
     
     By the definition determinant can be calculated only for square matrices. If you'll try to call this method on non-square matrix method returns nil:
     
         let nonSquare = """
         1 2 3
         4 5 6
         """
         let nonSquareMatrix = Matrix<Int>(string: nonSquare)!
     
         let failedDeterminant = nonSquareMatrix.determinant()
     
         print(failedDeterminant)
     
         // Prints:
         //
         // Matrix isn't square; operation of calculation of determinant is acceptable only for square matrices
         // nil
    */
    func determinant() -> Element? {
        guard isSquare else  {
            print("Matrix isn't square; operation of calculation of determinant is acceptable only for square matrices")
            return nil
        }
        
        if size.rows == 1 {
            return matrix[0][0]
        }
        
        var result = Element.zero
        for j in 0..<size.columns {
            let sign = j.isOdd ? -Element.one : Element.one
            let cofactorExpansion = sign * unsafeMakeMatrixRemoving(rows: [0], columns: [j]).determinant()! // "Алгебраическое дополнение" on Russian
            result += matrix[0][j] * cofactorExpansion
        }
        return result
    }
    
    // Lighter version of the makeMatrixChoosing(rows:columns:) method where empty collections and out of range checks were removed. Created only for use inside of the determinant() method, for better perfomance of the algorithm.
    private func unsafeMakeMatrixChoosing(rows: [Int], columns: [Int]) -> Matrix {
        let rows = Set<Int>(rows).sorted() // removing repeating elements
        let columns = Set<Int>(columns).sorted()
        
        var result = Matrix<Element>(zeroMatrixOfSize: (rows.count, columns.count))
        
        for i in 0..<rows.count {
            for j in 0..<columns.count {
                let row = rows[i]
                let column = columns[j]
                result[i, j] = matrix[row][column]
            }
        }
        
        return result
    }
    
    // Lighter version of the makeMatrixRemoving(rows:columns:) method where empty collections and out of range checks were removed. Created only for use inside of the determinant() method, for better perfomance of the algorithm.
    private func unsafeMakeMatrixRemoving(rows: [Int], columns: [Int]) -> Matrix {
        let crossedOffRows = Set<Int>(rows)
        let crossedOffColumns = Set<Int>(columns)
        
        let rangeOffAllPossibleRows = Set<Int>(0..<size.rows)
        let rangeOffAllPossibleColumns = Set<Int>(0..<size.columns)
        
        let chosenRows = rangeOffAllPossibleRows.subtracting(crossedOffRows).sorted()
        let chosenColumns = rangeOffAllPossibleColumns.subtracting(crossedOffColumns).sorted()
        
        return unsafeMakeMatrixChoosing(rows: chosenRows, columns: chosenColumns)
    }
    
    // MARK: - Determining degeneration of matrix
    
    /**
     A Boolean value indicating whether the matrix is degenerate.
     
         let nonDegenerate = """
         2 -5 4 3
         3 -4 7 5
         4 -9 8 5
         -3 2 -5 3
         """
         let degenerate = """
         0 0 0
         1 2 3
         4 7 8
         """
     
         let nonDegenerateMatrix = Matrix<Int>(string: nonDegenerate)!
         let degenerateMatrix = Matrix<Int>(string: degenerate)!
     
         print(nonDegenerateMatrix.isDegenerate)
         print(degenerateMatrix.isDegenerate)
     
         // false
         // true
    */
    public var isDegenerate: Bool {
        return determinant() == Element.zero
    }
    
    // MARK: - Determining symmetricity/antisymmetricity of matrix
    
    /**
     A Boolean value indicating whether the matrix is symmetric.
     
         let nonSymmetric = """
         1 5 3 8
         4 3 6 8
         1 5 4 7
         3 8 2 8
         """
         let symmetric = """
         1 7 4 6
         7 3 0 4
         4 0 2 5
         6 4 5 9
         """
     
         let nonSymmetricMatrix = Matrix<Int>(string: nonSymmetric)!
         let symmetricMatrix = Matrix<Int>(string: symmetric)!
     
         print(nonSymmetricMatrix.isSymmetric)
         print(symmetricMatrix.isSymmetric)
     
         // false
         // true
     
     By definition symmetric must be square, so for all non-square matrices the property will always be equal to `false`:
     
         let nonSquare = """
         1 2 3 4
         3 2 4 5
         1 2 3 5
         """
         let nonSquareMatrix = Matrix<Int>(string: nonSquare)!
     
         print(nonSquareMatrix.isSymmetric)
     
         // false
    */
    public var isSymmetric: Bool {
        return isSquare && self.transposed() == self
    }
    
    /**
     A Boolean value indicating whether the matrix is antisymmetric.
     
         let nonAntisymmetric = """
         1 5 3 8
         4 3 6 8
         1 5 4 7
         3 8 2 8
         """
         let antisymmetric = """
          0 -7 -4  6
          7  0  1 -4
          4 -1  0  5
         -6  4 -5  0
         """
     
         let nonAntisymmetricMatrix = Matrix<Int>(string: nonAntisymmetric)!
         let antisymmetricMatrix = Matrix<Int>(string: antisymmetric)!
     
         print(nonAntisymmetricMatrix.isAntisymmetric)
         print(antisymmetricMatrix.isAntisymmetric)
     
         // false
         // true
     
     By definition antisymmetric must be square, so for all non-square matrices the property will always be equal to `false`:
     
         let nonSquare = """
         1 2 3 4
         3 2 4 5
         1 2 3 5
         """
         let nonSquareMatrix = Matrix<Int>(string: nonSquare)!
     
         print(nonSquareMatrix.isAntisymmetric)
     
         // false
     */
    public var isAntisymmetric: Bool {
        return isSquare && -self.transposed() == self
    }
}

