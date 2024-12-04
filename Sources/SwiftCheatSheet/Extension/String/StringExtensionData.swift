//
//  Data.swift
//  
//
//  Created by TommyFuture on 11/20/24.
//

import Foundation


// MARK: - Data
public extension String
{
    /// 문자열을 지정된 인코딩 방식으로 `Data` 타입으로 변환합니다.
    /// - Parameter encoding: 문자열을 인코딩할 방식. 기본값은 `.utf8`입니다.
    /// - Returns: 변환된 `Data` 객체. 변환이 실패하면 `nil`을 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let text = "Hello, World!"
    /// if let data = text.toData() {
    ///     print(data) // UTF-8로 인코딩된 Data 객체
    /// }
    /// if let data = text.toData(using: .ascii) {
    ///     print(data) // ASCII로 인코딩된 Data 객체
    /// }
    /// ```
    func toData(using encoding: String.Encoding = .utf8) -> Data?
    {
        return self.data(using: encoding)
    }
}
