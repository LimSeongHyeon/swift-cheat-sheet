//
//  File.swift
//  
//
//  Created by TommyFuture on 7/18/24.
//

import Foundation
import Alamofire

public extension MultipartFormData
{
    /// `Codable` 타입의 파라미터를 JSON으로 인코딩한 후, 멀티파트 폼 데이터에 추가합니다.
    /// - Parameter parameters: JSON으로 인코딩할 `Codable` 타입의 파라미터.
    ///
    /// 이 함수는 `Codable` 객체를 JSON으로 변환한 후, 그 데이터를 멀티파트 폼 데이터에 추가합니다.
    ///
    /// - Usage:
    /// ```swift
    /// struct User: Codable {
    ///     var name: String
    ///     var age: Int
    /// }
    ///
    /// let formData = MultipartFormData()
    /// let user = User(name: "John", age: 30)
    /// formData.append(user)
    /// ```
    func append<T: Codable>( _ parameters: T)
    {
        do
        {
            let data = try JSONEncoder().encode(parameters)
            if let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            {
                append(dictionary)
            }
        }
        catch {}
    }
    
    
    /// 파라미터 딕셔너리를 멀티파트 폼 데이터에 추가합니다.
    /// - Parameter parameters: 문자열 키와 값으로 이루어진 파라미터 딕셔너리.
    ///
    /// 이 함수는 딕셔너리에서 각 키와 값을 문자열로 변환한 후, 이를 멀티파트 폼 데이터에 추가합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let formData = MultipartFormData()
    /// let parameters = ["name": "John", "age": "30"]
    /// formData.append(parameters)
    /// ```
    func append( _ parameters: Parameters)
    {
        for (key, value) in parameters
        {
            if let data = "\(value)".data(using: .utf8)
            {
                self.append(data, withName: key)
            }
        }
    }
    
    
    /// JSON으로 인코딩된 파라미터 데이터를 특정 키로 멀티파트 폼 데이터에 추가합니다.
    /// - Parameters:
    ///   - key: 멀티파트 폼 데이터에 사용할 키.
    ///   - data: JSON으로 인코딩할 파라미터 데이터.
    ///
    /// 이 함수는 딕셔너리 파라미터를 JSON 문자열로 변환한 후, 그 데이터를 멀티파트 폼 데이터에 추가합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let formData = MultipartFormData()
    /// let parameters = ["name": "John", "age": 30]
    /// formData.appendAsJson(name: "user", data: parameters)
    /// ```
    func appendAsJson(name key: String, data: Parameters)
    {
        if let params = data.toJsonString()?.toData()
        {
            self.append(params, withName: key)
        }
    }
}
