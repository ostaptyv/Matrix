//
//  StringInitializerService.swift
//  Matrix
//
//  Created by Ostap Tyvonovych on 04.10.2020.
//  Copyright © 2020 OstapTyvonovych. All rights reserved.
//

import Foundation

struct StringInitializerService<Element: Descriptionable> {
    
    // MARK: - Public method
    
    func convert(stringToMatrixArray string: String) -> [[Element]]? {
        var string = string
        
        if string.isEmpty || haveForeignCharacters(string: string) {
            return nil
        }
        
        string = string.replacingOccurrences(of: "\t", with: " ")

        let arrayOfSubstringLines = string.split(separator: "\n")
        let arrayOfLines = convertToArrayOfString(from: arrayOfSubstringLines)

        var matrixWithStringNumbers = [[String]]()
        
        for line in arrayOfLines {
            let arrayOfSubstringNumbers = line.split(separator: " ")
            let splittedNumbers = convertToArrayOfString(from: arrayOfSubstringNumbers)
            matrixWithStringNumbers.append(splittedNumbers)
        }
        
        return convert(stringMatrix: matrixWithStringNumbers)
    }
    
    // MARK: - Private use
    
    private func haveForeignCharacters(string: String) -> Bool {
        let setOfString = CharacterSet(charactersIn: string)
        let setOfPermittedCharacters = CharacterSet.matrixCharacters
        let setOfForeignCharacters = setOfString.subtracting(setOfPermittedCharacters)
        
        return !setOfForeignCharacters.isEmpty
    }
    
    private func convertToArrayOfString(from arrayOfSubstring: [Substring]) -> [String] {
        var arrayOfString = [String]()
        for substring in arrayOfSubstring {
            arrayOfString.append(String(substring))
        }
        return arrayOfString
    }
    
    private func convert(stringMatrix: [[String]]) -> [[Element]]? {
        var result: [[Element]] = []
        var isBreaked = false
        mainLoop: for line in stringMatrix {
            var resultLine = [Element]()
            for stringElement in line {
                let convertedElement = Element(stringElement)
                if let element = convertedElement {
                    resultLine.append(element)
                } else {
                    isBreaked = true
                    break mainLoop
                }
            }
            result.append(resultLine)
        }
        if isBreaked {
            return nil
        } else {
            return result
        }
    }
}

// MARK: - Matrix literal allowed characters

fileprivate extension CharacterSet {
    static var matrixCharacters = CharacterSet(charactersIn: "-0123456789.\n\t ")
}
