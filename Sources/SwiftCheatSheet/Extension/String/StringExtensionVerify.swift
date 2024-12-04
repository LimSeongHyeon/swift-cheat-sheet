//
//  Verify.swift
//
//
//  Created by TommyFuture on 11/20/24.
//

import Foundation

public extension String
{
    /// 컬렉션이 비어 있지 않은지 확인하는 계산 속성.
    /// - Returns: 컬렉션이 비어 있지 않으면 `true`, 비어 있으면 `false`를 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let text = "Hello"
    /// print(text.isExisting) // true
    ///
    /// let emptyText = ""
    /// print(emptyText.isExisting) // false
    /// ```
    var isExisting: Bool { !self.isEmpty }
    
    
    /// 문자열이 주어진 패턴과 일치하는지 확인합니다.
    /// - Parameter pattern: 일치시킬 정규 표현식 패턴.
    /// - Returns: 문자열이 패턴과 일치하면 `true`, 그렇지 않으면 `false`를 반환합니다.
    ///
    ///  ex) 대한민국 휴대폰 번호 형식에 대한 패턴은 "^010-[0-9]{4}-[0-9]{4}$"입니다. 해당 패턴을 이용하면 "010-XXXX-XXXX" 형식의 대한민국 휴대폰 번호 유효성 검사를 할 수 있습니다.
    ///
    /// - Usage:
    /// ```swift
    /// let contact = "010-1234-5678"
    /// let contactPattern = "^[A-Z]{4}[0-9]{4}$"
    /// if contact.matchesPattern(contactPattern) { /* String matches custom pattern. */ }
    /// else { /* String does not match custom pattern. */}
    /// ```
    func matchesPattern(_ pattern: String) -> Bool
    {
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return predicate.evaluate(with: self)
    }
    
    
    /// 문자열이 주어진 가변 인자에 포함되어 있는지 확인합니다.
    /// - Parameter words: 검색할 문자열들의 가변 길이 리스트.
    /// - Returns: 문자열이 가변 인자에 하나라도 포함되어 있으면 `true`, 그렇지 않으면 `false`를 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// if searchText.isIncluded(in: "John", "John Doe", "12345", "30") { /* Search text is included in one of the provided strings. */ }
    /// else { /* Search text is not included in any of the provided strings. */ }
    /// ```
    func isIncluded(in words: String...) -> Bool
    {
        return isIncluded(in: words)
    }
    
    
    /// 문자열이 주어진 반복 가능한 컬렉션(배열, 집합 등)에 포함되어 있는지 확인합니다.
    /// - Parameter words: 검색할 문자열들의 반복 가능한 컬렉션 (배열, 집합, 가변 인자 등).
    /// - Returns: 문자열이 컬렉션 내의 하나라도 포함되어 있으면 `true`, 그렇지 않으면 `false`를 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let searchText = "John"
    ///
    /// if searchText.isIncluded(in: ["John Doe", "12345", "30"]) { /* Search text is included in one of the provided strings. */ }
    /// else { /* Search text is not included in any of the provided strings. */ }
    /// ```
    func isIncluded<S: Sequence>(in words: S) -> Bool where S.Element == String
    {
        for word in words 
        {
            guard word.isExisting else { continue }
            if word.localizedCaseInsensitiveContains(self) { return true }
        }
        return false
    }
    
    
    /// 문자열에 주어진 가변 길이의 문자열들이 포함되어 있는지 확인합니다.
    /// - Parameter words: 검색할 문자열들의 가변 길이 리스트.
    /// - Returns: 문자열에 하나라도 포함되어 있으면 `true`, 그렇지 않으면 `false`를 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let bookContent = "The quick brown fox jumps over the lazy dog."
    /// if bookContent.includes("John", "developer", "senior") { /* Book content includes one of the provided strings. */ }
    /// else { /* Book content does not include any of the provided strings. */ }
    /// ```
    func includes(_ words: String...) -> Bool
    {
        return includes(words)
    }
    
    
    /// 문자열에 주어진 반복 가능한 컬렉션(배열, 집합 등)의 문자열들이 포함되어 있는지 확인합니다.
    /// - Parameter words: 검색할 문자열들의 반복 가능한 컬렉션 (배열, 집합 등).
    /// - Returns: 문자열에 하나라도 포함되어 있으면 `true`, 그렇지 않으면 `false`를 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let bookContent = "The quick brown fox jumps over the lazy dog."
    /// let words = ["John", "developer", "senior"]
    /// if bookContent.includes(words) { /* Book content includes one of the provided strings. */ }
    /// else { /* Book content does not include any of the provided strings. */ }
    /// ```
    func includes<S: Sequence>(_ words: S) -> Bool where S.Element == String
    {
        for word in words
        {
            guard word.isExisting else { continue }
            if self.localizedCaseInsensitiveContains(word) { return true }
        }
        return false
    }
}
