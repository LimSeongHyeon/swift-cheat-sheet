//
//  Formatting.swift
//
//
//  Created by TommyFuture on 11/20/24.
//

import Foundation


// MARK: - Formatting Or Mask (Return String)
public extension String
{
    /// 문자열을 지정된 길이의 블록들로 나누어 구분자와 함께 포맷팅합니다.
    /// - Parameters:
    ///   - blocks: 각 블록의 길이를 지정하는 가변 길이 정수 리스트.
    ///   - separator: 블록들을 구분하는 구분자 문자열. 기본값은 "-"입니다.
    /// - Returns: 지정된 블록 길이와 구분자로 포맷팅된 문자열.
    ///
    /// 이 함수는 문자열을 지정된 길이의 블록들로 나누어, 주어진 구분자로 구분합니다.
    /// 문자열의 총 길이가 블록의 총 길이보다 긴 경우, 최대 크기에 맞게 마지막 문자들을 잘라냅니다.
    ///
    /// - Usage:
    /// ```swift
    /// let myString = "1234567890"
    /// let formattedString = myString.formatBlocks(3, 2, 4) // "123-45-6789"
    /// let anotherFormattedString = myString.formatBlocks(3, 2, 4, separator: ":") // "123:45:6789"
    /// ```
    func formatBlocks(_ blocks: Int..., separator: String = "-") -> String
    {
        // 전체 문자열 길이를 초과하는 블록 길이의 합을 계산
        let totalLength = blocks.reduce(0, +)
        
        // 만약 전체 길이가 문자열 길이를 초과하면 문자열을 잘라냄
        let truncatedString = self.prefix(totalLength)
        
        var result = ""
        var currentIndex = truncatedString.startIndex
        
        for (index, block) in blocks.enumerated() 
        {
            let endIndex = truncatedString.index(currentIndex, offsetBy: block, limitedBy: truncatedString.endIndex) ?? truncatedString.endIndex
            result += truncatedString[currentIndex..<endIndex]
            
            
            if index < blocks.count - 1 && endIndex != truncatedString.endIndex
            {
                result += separator
            }
            
            currentIndex = endIndex
            
            if currentIndex == truncatedString.endIndex { break }
        }
        
        return result
    }
    
    
    /// 주어진 패턴과 마스킹 기호를 기반으로 문자열을 마스킹합니다.
    /// - Parameters:
    ///   - pattern: 문자열 형식을 나타내는 패턴. 숫자와 문자를 구분하여 나타냅니다.
    ///   - symbol: 마스킹에 사용할 기호.
    /// - Returns: 패턴이 일치하면 마스킹된 문자열을 반환하며, 그렇지 않으면 원래 문자열을 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let phoneNumber = "010-1234-5678"
    /// print(phoneNumber.mask(like: "000-****-0000", symbol: "*")) // "010-****-5678"
    ///
    /// let rrn = "240108-1644855"
    /// print(rrn.mask(like: "000000-*******", symbol: "*")) // "240108-*******"
    /// ```
    func mask(like pattern: String, symbol: Character = "*") -> String 
    {
        let truncatedString = String(self.prefix(pattern.count))
        
        guard !truncatedString.isEmpty else { return self }
        
        var maskedString = ""
        let selfArray = Array(truncatedString)
        let patternArray = Array(pattern)
        
        guard selfArray.count == patternArray.count else { return self }
        
        for i in 0..<patternArray.count 
        {
            print(selfArray[i], patternArray[i])
            
            if patternArray[i] != symbol,
               selfArray[i].isNumber != patternArray[i].isNumber { return self }
            
            maskedString.append(patternArray[i] == symbol ? symbol : selfArray[i])
        }
        
        return maskedString
    }
    
    
    /// 문자열에서 지정된 문자를 이스케이프(앞에 백슬래시(`\`)를 추가)합니다.
    /// - Parameter escapingCharacters: 문자열에서 이스케이프할 문자들의 집합.
    /// - Returns: `escapingCharacters`에 있는 모든 문자의 앞에 백슬래시(`\`)가 추가된 새로운 문자열을 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let text = "Hello *world*"
    /// let escapedText = text.escapeCharacters(["*"])
    /// print(escapedText) // "Hello \*world\*"
    /// ```
    func escapeCharacters( _ escapingCharacters: Set<String>) -> String
    {
        var escapedString = self
        escapingCharacters.forEach{ escapedString = escapedString.replacingOccurrences(of: $0, with: "\\\($0)") }
        
        return escapedString
    }
}
