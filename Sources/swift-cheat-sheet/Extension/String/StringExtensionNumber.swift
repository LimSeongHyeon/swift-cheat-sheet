//
//  Number.swift
//
//
//  Created by TommyFuture on 11/20/24.
//

import Foundation

// MARK: - Numbers
public extension String
{
    /// 문자열에서 숫자만 추출하여 정수 값으로 변환합니다.
    /// - Returns: 문자열에 포함된 숫자를 정수로 변환하여 반환합니다. 숫자가 없으면 `nil`을 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let text = "abc123def"
    /// print(text.getIntValue()) // Optional(123)
    ///
    /// let noNumbers = "abcdef"
    /// print(noNumbers.getIntValue()) // nil
    /// ```
    func getIntValue() -> Int?
    {
        let numbersOnly = self.filter { $0.isWholeNumber }
        return Int(numbersOnly)
    }
    
    
    /// 문자열에서 숫자만 추출하여 반환합니다.
    /// - Returns: 문자열에 포함된 숫자만을 연결한 새로운 문자열을 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let text = "abc123def"
    /// print(text.getOnlyNumbers()) // "123"
    ///
    /// let noNumbers = "abcdef"
    /// print(noNumbers.getOnlyNumbers()) // ""
    /// ```
    func getOnlyNumbers() -> String
    {
        return self.filter { $0.isWholeNumber }
    }
    
    
    /// 문자열에서 숫자를 제거한 새로운 문자열을 반환합니다.
    /// - Returns: 원래 문자열에서 숫자를 제거한 문자열을 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let text = "abc123def"
    /// print(text.removeNumbers()) // "abcdef"
    ///
    /// let onlyNumbers = "123456"
    /// print(onlyNumbers.removeNumbers()) // ""
    /// ```
    func removeNumbers() -> String
    {
        var result = ""
        result.reserveCapacity(count)
        
        for char in self {
            if !char.isNumber {
                result.append(char)
            }
        }
        
        return result
    }
}
