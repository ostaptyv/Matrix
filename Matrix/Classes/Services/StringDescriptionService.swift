//
//  StringDescriptionService.swift
//  Matrix
//
//  Created by Ostap Tyvonovych on 04.10.2020.
//  Copyright © 2020 OstapTyvonovych. All rights reserved.
//

struct StringDescriptionService<Element: Descriptionable> {
    
    // MARK: - Public method
    
    func makeDescription(using matrix: [[Element]], for size: (rows: Int, columns: Int)) -> String {
        let array = convert(matrix: matrix) { element in
            return element.description
        }
        let theLongestStringInColumn = getDictionaryWithTheLongestStringInColumn(from: array, for: size)
        
        var result = ""
        
        for i in 0..<size.rows {
            for j in 0..<size.columns {
                var element = array[i][j]
                
                while theLongestStringInColumn[j]! != element.count {
                    element += " "
                }
                
                if !element.contains("-") {
                    element = " " + element
                } else {
                    element = element + " "
                }
                
                element += "   "
                result += element
            }
            result += "\n"
        }
        result.removeLast()
        
        return result
    }
    
    // MARK: - Private use
    
    private func convert<Convertable, Converted>(matrix: [[Convertable]], rule: (Convertable) -> Converted) -> [[Converted]] {
        var result: [[Converted]] = []
        for line in matrix {
            var convertedLine = [Converted]()
            for element in line {
                convertedLine.append(rule(element))
            }
            result.append(convertedLine)
        }
        return result
    }
    
    private func getDictionaryWithTheLongestStringInColumn(from array: [[String]], for size: (rows: Int, columns: Int)) -> [Int: Int] {
        var theLongestStringInColumn = [Int: Int]()
        
        for j in 0..<size.columns {
            theLongestStringInColumn[j] = 0
            for i in 0..<size.rows {
                let stringLength = array[i][j].count
                if theLongestStringInColumn[j]! < stringLength {
                    theLongestStringInColumn[j] = stringLength
                }
            }
        }
        return theLongestStringInColumn
    }
}
