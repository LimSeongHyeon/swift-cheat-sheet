//
//  StringUtilityTests.swift
//
//
//  Created by TommyFuture on 11/20/24.
//

import XCTest

final class StringConvertTests: XCTestCase
{
    func testSplitByCaseStyle() {
        XCTAssertEqual("splitAndNormalize".splitByCaseStyle(), ["split", "and", "normalize"])
        XCTAssertEqual("split_and_normalize".splitByCaseStyle(), ["split", "and", "normalize"])
        XCTAssertEqual("split-and-normalize".splitByCaseStyle(), ["split", "and", "normalize"])
        XCTAssertEqual("SplitAndNormalize".splitByCaseStyle(), ["split", "and", "normalize"])
        XCTAssertEqual("SPLIT_AND_NORMALIZE".splitByCaseStyle(), ["split", "and", "normalize"])
        XCTAssertEqual("split.and.normalize".splitByCaseStyle(), ["split", "and", "normalize"])
        XCTAssertEqual("".splitByCaseStyle(), [])
    }
    
    func testSlice() {
        XCTAssertEqual("Hello, world!".slice(5), "Hello")
        XCTAssertEqual("Hello, world!".slice(20), "Hello, world!")
        XCTAssertEqual("".slice(5), "")
    }
    
    func testRemoveSuffix() {
        XCTAssertEqual("HelloWorld".removeSuffix("World"), "Hello")
        XCTAssertEqual("HelloWorld".removeSuffix("Swift"), "HelloWorld")
        XCTAssertEqual("".removeSuffix("Test"), "")
    }
    
    func testRemoveAnySuffix() {
        XCTAssertEqual("HelloWorld".removeAnySuffix("World", "Swift"), "Hello")
        XCTAssertEqual("HelloWorld".removeAnySuffix("Swift", "World"), "Hello")
        XCTAssertEqual("HelloWorld".removeAnySuffix("Universe"), "HelloWorld")
        XCTAssertEqual("".removeAnySuffix("Test"), "")
    }
    
    func testRemovePrefix() {
        XCTAssertEqual("HelloWorld".removePrefix("Hello"), "World")
        XCTAssertEqual("HelloWorld".removePrefix("Swift"), "HelloWorld")
        XCTAssertEqual("".removePrefix("Test"), "")
    }
    
    func testRemoveAnyPrefix() {
        XCTAssertEqual("HelloWorld".removeAnyPrefix("Hello", "Hi"), "World")
        XCTAssertEqual("HelloWorld".removeAnyPrefix("Hi", "Hello"), "World")
        XCTAssertEqual("HelloWorld".removeAnyPrefix("Swift"), "HelloWorld")
        XCTAssertEqual("".removeAnyPrefix("Test"), "")
    }
    
    func testEdgeCases() {
        XCTAssertEqual("----".splitByCaseStyle(), [])
        XCTAssertEqual("___".removeSuffix("_"), "__")
        XCTAssertEqual("Hello".removePrefix("HelloWorld"), "Hello")
        XCTAssertEqual("123_test".splitByCaseStyle(), ["123", "test"])
    }
}
