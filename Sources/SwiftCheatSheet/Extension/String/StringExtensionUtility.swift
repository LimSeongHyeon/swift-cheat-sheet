//
//  Utility.swift
//
//
//  Created by TommyFuture on 11/20/24.
//

import Foundation

public let DEFAULT_MARKDOWN_ESCAPING_CHARS: Set<String> = ["\\", "`", "*", "_", "{", "}", "[", "]", 
                                                           "(", ")", "#", "+", "-", ".", "!", "~",
                                                           "|", ":", "<", ">", "&"]



public enum CaseStylePattern: String, CaseIterable
{
    case snakeCase = "^[a-z0-9]+(?:_[a-z0-9]+)*$"
    case camelCase = "^[a-z0-9]+(?:[A-Z][a-z0-9]*)*$"
    case kebabCase = "^[a-z0-9]+(?:-[a-z0-9]+)*$"
    case pascalCase = "^[A-Z][a-z0-9]*(?:[A-Z][a-z0-9]*)*$"
    case screamingSnakeCase = "^[A-Z0-9]+(?:_[A-Z0-9]+)*$"
    case dotCase = "^[a-z0-9]+(?:\\.[a-z0-9]+)*$"
    
    
    public var seperatePattern: String
    {
        switch self
        {
        case .camelCase: return "([a-z0-9])([A-Z0-9])"
        case .pascalCase: return "(?<=[A-Z])(?=[A-Z][a-z])|(?<=[^A-Z])(?=[A-Z])|(?<=[A-Za-z])(?=[^A-Za-z])"
        case .snakeCase, .screamingSnakeCase: return "_"
        case .kebabCase: return "-"
        case .dotCase: return "."
        }
    }
    
    var isRegexSeparator: Bool { self.seperatePattern.count > 1 }
    
    public func splitAndNormalize(_ input: String) -> [String]
    {
        if isRegexSeparator
        {
            let regex = try! NSRegularExpression(pattern: self.seperatePattern)
            let range = NSRange(input.startIndex..<input.endIndex, in: input)
            let result = regex.stringByReplacingMatches(
                in: input,
                options: [],
                range: range,
                withTemplate: "$1 $2"
            )
            return result.split(separator: " ").map { $0.lowercased() }
        }
        else
        {
            return input.split(separator: Character(self.seperatePattern)).map { $0.lowercased() }
        }
    }
}


public extension String
{
    /// 문자열의 CaseStyle을 감지하고 split합니다.
    /// - Parameters:
    ///   - None: 해당 메소드는 Parameter가 존재하지 않습니다.
    ///
    /// - Returns: 해당 문자열에 맞는 case style로 split하여 [String]으로 반환합니다.
    ///
    /// - CaseStylePattern:
    /// CaseStylePattern에 정의된 snake case, camel case, kebab case, pascal case, screaming snake case, dot case에 한하여 동작합니다.
    ///
    /// - Usage:
    /// ```swift
    /// "splitAndNormalize".splitByCaseStyle() // ["split", "and", "normalize"]
    /// "split_and_normalize".splitByCaseStyle() // ["split", "and", "normalize"]
    /// "split-and-normalize".splitByCaseStyle() // ["split", "and", "normalize"]
    /// "SplitAndNormalize".splitByCaseStyle() // ["split", "and", "normalize"]
    /// "SPLIT_AND_NORMALIZE".splitByCaseStyle() // ["split", "and", "normalize"]
    /// "split.and.normalize".splitByCaseStyle() // ["split", "and", "normalize"]
    /// ```
    func splitByCaseStyle() -> [String]
    {
        for pattern in CaseStylePattern.allCases
        {
            if let regex = try? NSRegularExpression(pattern: pattern.rawValue),
               regex.firstMatch(in: self, options: [], range: NSRange(self.startIndex..<self.endIndex, in: self)) != nil
            {
                return pattern.splitAndNormalize(self)
            }
        }
        
        return []
    }
    
    
    
    /// 문자열을 지정된 길이로 잘라 반환합니다.
    /// - Parameter number: 자를 문자열의 길이.
    /// - Returns: 지정된 길이로 자른 문자열. 원래 문자열의 길이가 지정된 길이보다 짧으면 원래 문자열을 그대로 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let text = "Hello, world!"
    /// print(text.slice(5)) // "Hello"
    /// print(text.slice(20)) // "Hello, world!" (원래 문자열이 반환됩니다)
    /// ```
    func slice( _ number: Int) -> String
    {
        if self.count > number
        {
            let truncatedIndex = self.index(self.startIndex, offsetBy: number)
            return "\(self[..<truncatedIndex])"
        }
        else
        {
            return self
        }
    }
    
    
    
}



// MARK: - Suffix, Preffix
public extension String
{
    /// 문자열에서 지정된 접미사를 제거합니다.
    /// - Parameter suffix: 제거할 접미사.
    /// - Returns: 문자열이 해당 접미사로 끝나면 접미사를 제거한 문자열을 반환하고, 그렇지 않으면 원래 문자열을 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let text = "HelloWorld"
    /// print(text.removeSuffix("World")) // "Hello"
    /// print(text.removeSuffix("Swift")) // "HelloWorld" (변경 없음)
    /// ```
    func removeSuffix(_ suffix: String) -> String
    {
        if self.hasSuffix(suffix)
        {
            return String(self.dropLast(suffix.count))
        }
        return self
    }
    
    
    /// 문자열에서 지정된 길이만큼의 접미사를 제거합니다.
    /// - Parameter n: 제거할 문자 수. 기본값은 1.
    /// - Returns: 문자열의 길이가 지정된 길이보다 크면 접미사를 제거한 문자열을 반환하고, 그렇지 않으면 빈 문자열을 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let text = "HelloWorld"
    /// print(text.removeSuffix(5)) // "Hello"
    /// print(text.removeSuffix())   // "HelloWorl" (기본값으로 마지막 문자 1개 제거)
    /// print(text.removeSuffix(15)) // "" (문자열 길이보다 클 경우 빈 문자열 반환)
    /// ```
    func removeSuffix(_ n: Int = 1) -> String
    {
        let count = self.count
        return (count > n) ? String(self.dropLast(n)) : ""
    }
    
    
    /// 문자열에서 주어진 접미사들 중 하나를 제거합니다.
    /// - Parameter suffixes: 제거할 접미사들의 가변 길이 리스트.
    /// - Returns: 문자열이 접미사들 중 하나로 끝나면 해당 접미사를 제거한 문자열을 반환하고, 그렇지 않으면 원래 문자열을 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let text = "HelloWorld"
    /// print(text.removeAnySuffix("World", "Swift")) // "Hello"
    /// print(text.removeAnySuffix("Swift", "World")) // "Hello" (첫 번째로 일치하는 접미사 제거)
    /// print(text.removeAnySuffix("Universe"))       // "HelloWorld" (변경 없음)
    /// ```
    func removeAnySuffix(_ suffixes: String...) -> String
    {
        return removeAnySuffix(suffixes)
    }
    
    
    /// 문자열에서 주어진 접미사들 중 하나를 제거합니다.
    /// - Parameter suffixes: 제거할 접미사들의 반복 가능한 컬렉션 (배열, 집합 등).
    /// - Returns: 문자열이 접미사들 중 하나로 끝나면 해당 접미사를 제거한 문자열을 반환하고, 그렇지 않으면 원래 문자열을 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let text = "HelloWorld"
    /// print(text.removeAnySuffix(["World", "Swift"])) // "Hello"
    /// print(text.removeAnySuffix(["Swift", "World"])) // "Hello" (첫 번째로 일치하는 접미사 제거)
    /// print(text.removeAnySuffix(Set(["Universe", "World"]))) // "Hello"
    /// print(text.removeAnySuffix(["Universe"]))       // "HelloWorld" (변경 없음)
    /// ```
    func removeAnySuffix<S: Sequence>(_ suffixes: S) -> String where S.Element == String
    {
        for suffix in suffixes
        {
            if self.hasSuffix(suffix)
            {
                return String(self.dropLast(suffix.count))
            }
        }
        return self
    }
    
    
    /// 문자열에서 지정된 접두사를 제거합니다.
    /// - Parameter prefix: 제거할 접두사.
    /// - Returns: 문자열이 해당 접두사로 시작하면 접두사를 제거한 문자열을 반환하고, 그렇지 않으면 원래 문자열을 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let text = "HelloWorld"
    /// print(text.removePrefix("Hello")) // "World"
    /// print(text.removePrefix("Swift")) // "HelloWorld" (변경 없음)
    /// ```
    func removePrefix(_ prefix: String) -> String
    {
        if self.hasPrefix(prefix)
        {
            return String(self.dropFirst(prefix.count))
        }
        return self
    }
    
    
    /// 문자열에서 지정된 길이만큼의 접두사를 제거합니다.
    /// - Parameter n: 제거할 문자 수. 기본값은 1.
    /// - Returns: 문자열의 길이가 지정된 길이보다 크면 접두사를 제거한 문자열을 반환하고, 그렇지 않으면 빈 문자열을 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let text = "HelloWorld"
    /// print(text.removePrefix(5)) // "World"
    /// print(text.removePrefix())   // "elloWorld" (기본값으로 첫 번째 문자 제거)
    /// print(text.removePrefix(15)) // "" (문자열 길이보다 클 경우 빈 문자열 반환)
    /// ```
    func removePrefix(_ n: Int = 1) -> String
    {
        let count = self.count
        return (count > n) ? String(self.dropFirst(n)) : ""
    }
    
    
    /// 문자열에서 주어진 접두사들 중 하나를 제거합니다.
    /// - Parameter prefixes: 제거할 접두사들의 가변 길이 리스트.
    /// - Returns: 문자열이 접두사들 중 하나로 시작하면 해당 접두사를 제거한 문자열을 반환하고, 그렇지 않으면 원래 문자열을 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let text = "HelloWorld"
    /// print(text.removeAnyPrefix("Hello", "Hi")) // "World"
    /// print(text.removeAnyPrefix("Hi", "Hello")) // "World" (첫 번째로 일치하는 접두사 제거)
    /// print(text.removeAnyPrefix("Swift"))       // "HelloWorld" (변경 없음)
    /// ```
    func removeAnyPrefix(_ prefixes: String...) -> String
    {
        return removeAnyPrefix(prefixes)
    }
    
    
    /// 문자열에서 주어진 접두사들 중 하나를 제거합니다.
    /// - Parameter prefixes: 제거할 접두사들의 반복 가능한 컬렉션 (배열, 집합 등).
    /// - Returns: 문자열이 접두사들 중 하나로 시작하면 해당 접두사를 제거한 문자열을 반환하고, 그렇지 않으면 원래 문자열을 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let text = "HelloWorld"
    /// print(text.removeAnyPrefix(["Hello", "Hi"])) // "World"
    /// print(text.removeAnyPrefix(["Hi", "Hello"])) // "World" (첫 번째로 일치하는 접두사 제거)
    /// print(text.removeAnyPrefix(Set(["Swift", "Hello"]))) // "World"
    /// print(text.removeAnyPrefix(["Swift"]))       // "HelloWorld" (변경 없음)
    /// ```
    func removeAnyPrefix<S: Sequence>(_ prefixes: S) -> String where S.Element == String
    {
        for prefix in prefixes
        {
            if self.hasPrefix(prefix)
            {
                return String(self.dropFirst(prefix.count))
            }
        }
        return self
    }
}
