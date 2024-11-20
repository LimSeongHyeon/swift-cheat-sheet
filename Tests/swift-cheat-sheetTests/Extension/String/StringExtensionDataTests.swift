//
//  StringExtensionDataTests.swift
//  
//
//  Created by TommyFuture on 11/20/24.
//

import XCTest

final class StringExtensionDataTests: XCTestCase 
{

    func testToDataWithUTF8Encoding() 
    {
        let text = "Hello, World!"
        let expectedData = text.data(using: .utf8)
        XCTAssertEqual(text.toData(), expectedData)
    }
    
    func testToDataWithASCIIEncoding() 
    {
        let text = "Hello, ASCII!"
        let expectedData = text.data(using: .ascii)
        XCTAssertEqual(text.toData(using: .ascii), expectedData)
    }
    
    func testToDataWithInvalidEncoding() 
    {
        let text = "Hello, World! 😊"
        XCTAssertNil(text.toData(using: .ascii)) // ASCII cannot encode emojis
    }
    
    func testToDataWithEmptyString() 
    {
        let emptyText = ""
        let expectedData = emptyText.data(using: .utf8)
        XCTAssertEqual(emptyText.toData(), expectedData)
    }
    
    func testToDataWithNonUTF8Encoding() 
    {
        let text = "Hello, こんにちは"
        XCTAssertNotNil(text.toData(using: .iso2022JP))
    }
}
