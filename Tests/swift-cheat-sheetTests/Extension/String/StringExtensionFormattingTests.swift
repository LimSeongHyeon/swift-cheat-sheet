//
//  StringExtensionFormattingTests.swift
//  
//
//  Created by TommyFuture on 11/20/24.
//

import XCTest

final class StringExtensionFormattingTests: XCTestCase 
{
    func testFormatBlocks() 
    {
        XCTAssertEqual("1234567890".formatBlocks(3, 2, 4), "123-45-6789")
        XCTAssertEqual("1234567890".formatBlocks(3, 2, 4, separator: ":"), "123:45:6789")
        XCTAssertEqual("1234567890".formatBlocks(5, 5), "12345-67890")
        XCTAssertEqual("12345".formatBlocks(3, 2, 4), "123-45")
        XCTAssertEqual("".formatBlocks(3, 2, 4), "")
    }
    
    func testMask() 
    {
        XCTAssertEqual("010-1234-5678".mask(like: "000-****-0000", symbol: "*"), "010-****-5678")
        XCTAssertEqual("240108-1644855".mask(like: "000000-*******", symbol: "*"), "240108-*******")
        XCTAssertEqual("1234-5678".mask(like: "****-****", symbol: "*"), "****-****")
        XCTAssertEqual("1234abcd".mask(like: "****-****", symbol: "*"), "1234abcd")
        XCTAssertEqual("".mask(like: "000-****-0000", symbol: "*"), "")
    }
    
    func testEscapeCharacters() 
    {
        XCTAssertEqual("Hello *world*".escapeCharacters(["*"]), "Hello \\*world\\*")
        XCTAssertEqual("Special $characters$".escapeCharacters(["$", "#"]), "Special \\$characters\\$")
        XCTAssertEqual("NoEscapeHere".escapeCharacters(["*"]), "NoEscapeHere")
        XCTAssertEqual("".escapeCharacters(["*"]), "")
    }
}
