//
//  StringNumberTests.swift
//  
//
//  Created by TommyFuture on 11/20/24.
//

import XCTest

final class StringNumberTests: XCTestCase 
{

    func testGetIntValue() 
    {
        XCTAssertEqual("abc123def".getIntValue(), 123)
        XCTAssertEqual("123".getIntValue(), 123)
        XCTAssertEqual("0abc456".getIntValue(), 456)
        XCTAssertNil("abcdef".getIntValue())
        XCTAssertNil("".getIntValue())
        XCTAssertEqual("00123".getIntValue(), 123)
    }
    
    func testGetOnlyNumbers() 
    {
        XCTAssertEqual("abc123def".getOnlyNumbers(), "123")
        XCTAssertEqual("123".getOnlyNumbers(), "123")
        XCTAssertEqual("0abc456".getOnlyNumbers(), "0456")
        XCTAssertEqual("abcdef".getOnlyNumbers(), "")
        XCTAssertEqual("".getOnlyNumbers(), "")
        XCTAssertEqual("00123".getOnlyNumbers(), "00123")
    }
    
    func testRemoveNumbers() 
    {
        XCTAssertEqual("abc123def".removeNumbers(), "abcdef")
        XCTAssertEqual("123".removeNumbers(), "")
        XCTAssertEqual("0abc456".removeNumbers(), "abc")
        XCTAssertEqual("abcdef".removeNumbers(), "abcdef")
        XCTAssertEqual("".removeNumbers(), "")
    }
}
