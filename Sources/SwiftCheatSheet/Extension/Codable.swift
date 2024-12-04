//
//  File.swift
//  
//
//  Created by TommyFuture on 7/18/24.
//

import Foundation

public extension Encodable
{
    /// `Encodable` 객체를 JSON 문자열로 변환합니다.
    /// - Returns: 객체를 JSON 형식의 문자열로 변환하여 반환하며, 변환에 실패하면 `nil`을 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// struct User: Encodable {
    ///     var name: String
    ///     var age: Int
    /// }
    ///
    /// let user = User(name: "John", age: 30)
    /// if let jsonString = user.toJsonString() {
    ///     print(jsonString) // {"name":"John","age":30}
    /// }
    /// ```
    func toJsonString() -> String?
    {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(self)
            return String(data: jsonData, encoding: .utf8)
        }
        catch { return nil }
    }
    
    
    /// `Encodable` 객체를 딕셔너리로 변환합니다.
    /// - Returns: 객체의 속성들을 포함한 `[String: Any]` 딕셔너리를 반환하며, 변환에 실패하면 `nil`을 반환합니다. 객체의 속성명은 스네이크 케이스로 변환됩니다.
    ///
    /// - Usage:
    /// ```swift
    /// struct User: Encodable {
    ///     var name: String
    ///     var age: Int
    /// }
    ///
    /// let user = User(name: "John", age: 30)
    /// if let dict = user.asDictionary() {
    ///     print(dict) // ["name": "John", "age": 30]
    /// }
    /// ```
    func asDictionary() -> [String: Any]?
    {
        let mirror = Mirror(reflecting: self)
        
        var dict: [String: Any] = [:]
        for child in mirror.children
        {
            if let key = child.label
            {
                if let value = unwrap(child.value)
                {
                    dict[key.splitByCaseStyle().joined(separator: "_")] = value
                }
            }
        }
        return dict
    }
    
    
    
    /// 옵셔널 값을 언랩(unwrapping)하여 반환합니다.
    /// - Parameter any: 언랩할 값.
    /// - Returns: 옵셔널 값이 있으면 해당 값을 반환하고, 없으면 `nil`을 반환합니다.
    ///
    /// 이 함수는 내부적으로 사용되며, 옵셔널 타입의 값을 언랩하여 실제 값을 반환하거나 `nil`로 처리합니다.
    private func unwrap<T>( _ any: T) -> Any?
    {
        let mirror = Mirror(reflecting: any)
        if mirror.displayStyle == .optional
        {
            if mirror.children.count == 0 { return nil }
            let ( _, some) = mirror.children.first!
            return some
        }
        return any
    }
}

