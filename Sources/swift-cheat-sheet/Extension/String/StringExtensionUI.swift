//
//  StringExtensionUI.swift
//  
//
//  Created by TommyFuture on 11/20/24.
//

import Foundation
import SwiftUI

public extension String
{
    /// 문자열 내의 URL을 마크다운 스타일 링크로 변환하여 마스킹합니다.
    /// - Parameters:
    ///   - escapingCharacters: 마크다운 형식이 깨지지 않도록 이스케이프할 문자 집합. 기본값은 `\`, `*`, `_` 등의 마크다운 제어 문자들이 포함되어 있습니다.
    /// - Returns: URL이 마크다운 스타일 링크 `[URL](URL)`로 변환되고, 마크다운 문자들이 이스케이프된 `LocalizedStringKey`를 반환합니다.
    ///
    /// - defaultEscapeCharacters:
    /// ```swift
    /// ["\\", "`", "*", "_", "{", "}", "[", "]", "(", ")", "#", "+", "-", ".", "!", ">", "~", "|", ":", "<", ">", "&"]
    /// ```
    ///
    /// - Usage:
    /// ```swift
    /// let text = "Welcome: https://www.google.com"
    /// print(text.localizedMarkdownURLs()) // "Welcome: [https://www.google.com](https://www.google.com)"
    ///
    /// // in UI
    /// Text(text.localizedMarkdownURLs())
    /// ```
    func localizedMarkdownURLs(escapingCharacters: Set<String> = DEFAULT_MARKDOWN_ESCAPING_CHARS) -> LocalizedStringKey
    {
        let escapedText = self.escapeCharacters(escapingCharacters)
        
        let regexPattern = "(https?:\\/\\/[^\\s]+)"
        let regex = try! NSRegularExpression(pattern: regexPattern, options: [])
        let range = NSRange(escapedText.startIndex..<escapedText.endIndex, in: escapedText)
        let result = regex.stringByReplacingMatches(in: escapedText, options: [], range: range, withTemplate: "[$0]($0)")
        
        return LocalizedStringKey(result)
    }

}

