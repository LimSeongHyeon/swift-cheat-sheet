//
//  File.swift
//  
//
//  Created by TommyFuture on 7/18/24.
//

import Foundation

public extension Dictionary where Value: Equatable
{
    /// 딕셔너리에서 주어진 값과 일치하는 모든 키를 반환합니다.
    /// - Parameter val: 찾고자 하는 값.
    /// - Returns: 해당 값과 일치하는 모든 키의 배열을 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let dictionary = ["a": 1, "b": 2, "c": 1]
    /// let keys = dictionary.allKeys(forValue: 1) // ["a", "c"]
    /// ```
    func allKeys(forValue val: Value) -> [Key]
    {
        return self.filter { $1 == val }.map { $0.0 }
    }
}

public extension Dictionary where Key == String
{
    /// 문자열 키를 사용하는 딕셔너리를 JSON 문자열로 변환합니다.
    /// - Parameter prettyPrinted: JSON 출력이 사람이 읽기 좋게 포맷팅될지 여부. 기본값은 `false`입니다.
    /// - Returns: 딕셔너리를 JSON 형식의 문자열로 변환하여 반환하며, 변환에 실패하면 `nil`을 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let dictionary = ["name": "John", "age": 30]
    /// if let jsonString = dictionary.toJsonString(prettyPrinted: true) 
    /// {
    ///     print(jsonString)
    /// }
    /// ```
    func toJsonString(prettyPrinted: Bool = false) -> String?
    {
        do
        {
            let data = try JSONSerialization.data(withJSONObject: self, options: prettyPrinted ? .prettyPrinted : [])
            return String(data: data, encoding: .utf8)
        }
        catch { return nil }
    }
}

public extension Dictionary where Key == String, Value: Any
{
    /// 딕셔너리를 지정된 `Codable` 타입으로 변환합니다.
    /// - Parameter type: 변환할 `Codable` 타입.
    /// - Returns: 딕셔너리를 지정된 타입으로 변환하여 반환하며, 변환에 실패하면 `nil`을 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// struct User: Codable 
    /// {
    ///     var name: String
    ///     var age: Int
    /// }
    ///
    /// let dictionary = ["name": "John", "age": 30]
    /// if let user = dictionary.mapToCodable(User.self) 
    /// {
    ///     print(user.name) // "John"
    /// }
    /// ```
    func mapToCodable<T: Codable>(_ type: T.Type) -> T?
    {
        do
        {
            let jsonData = try JSONSerialization.data(withJSONObject: self)
            
            let decoder = JSONDecoder()
            let object = try decoder.decode(type, from: jsonData)
            return object
        } catch { return nil }
    }
}
