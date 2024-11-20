//
//  MultipartFormDataExtensionTests.swift
//  
//
//  Created by TommyFuture on 11/20/24.
//

import XCTest
import Alamofire

final class MultipartFormDataExtensionTests: XCTestCase 
{
    
    func testAppendCodable() 
    {
        struct User: Codable 
        {
            var name: String
            var age: Int
        }
        let formData = MultipartFormData()
        let user = User(name: "John", age: 30)
        
        formData.append(user)
        
        let jsonString = String(data: try! formData.encode(), encoding: .utf8)
        
        XCTAssertNotNil(jsonString)
        XCTAssertTrue(jsonString!.contains("name=\"name\"\r\n\r\nJohn"))
        XCTAssertTrue(jsonString!.contains("name=\"age\"\r\n\r\n30"))
    }
    
    func testAppendParameters() 
    {
        let formData = MultipartFormData()
        let parameters: Parameters = ["name": "John", "age": "30"]
        
        formData.append(parameters)
        
        let request = try! formData.encode()
        let jsonString = String(data: request, encoding: .utf8)
        XCTAssertNotNil(jsonString)
        XCTAssertTrue(jsonString!.contains("name"))
        XCTAssertTrue(jsonString!.contains("John"))
        XCTAssertTrue(jsonString!.contains("age"))
        XCTAssertTrue(jsonString!.contains("30"))
    }
    
    func testAppendAsJson() 
    {
        let formData = MultipartFormData()
        let parameters: Parameters = ["name": "John", "age": 30]
        
        formData.appendAsJson(name: "user", data: parameters)
        
        let request = try! formData.encode()
        let jsonString = String(data: request, encoding: .utf8)
        
        XCTAssertNotNil(jsonString)
        XCTAssertTrue(jsonString!.contains("name=\"user\""))
        XCTAssertTrue(jsonString!.contains("\"age\":30"))
        XCTAssertTrue(jsonString!.contains("\"name\":\"John\"}"))
    }
}
