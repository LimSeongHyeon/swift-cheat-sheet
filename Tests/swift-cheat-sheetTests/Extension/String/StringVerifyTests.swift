//
//  StringExtensionVerifyTests.swift
//  
//
//  Created by TommyFuture on 11/20/24.
//

import XCTest

final class StringVerifyTests: XCTestCase
{
    func testIsExisting() 
    {
        XCTAssertTrue("Hello".isExisting)
        XCTAssertFalse("".isExisting)
    }
    
    func testMatchesPattern() 
    {
        let validPhone = "010-1234-5678"
        let invalidPhone = "123-4567-8901"
        let pattern = "^010-[0-9]{4}-[0-9]{4}$"
        
        XCTAssertTrue(validPhone.matchesPattern(pattern))
        XCTAssertFalse(invalidPhone.matchesPattern(pattern))
    }
    
    func testIsIncludedWithVariadic() 
    {
        let searchText = "Hello"
        XCTAssertTrue(searchText.isIncluded(in: "Hello", "World"))
        XCTAssertFalse(searchText.isIncluded(in: "Hi", "World"))
    }
    
    func testIsIncludedWithCollection() 
    {
        let searchText = "Hello"
        let collection = ["Hello", "World"]
        XCTAssertTrue(searchText.isIncluded(in: collection))
        
        let nonMatchingCollection = ["Hi", "World"]
        XCTAssertFalse(searchText.isIncluded(in: nonMatchingCollection))
    }
    
    func testIncludesWithVariadic() 
    {
        let content = "The quick brown fox jumps over the lazy dog."
        XCTAssertTrue(content.includes("quick", "lazy"))
        XCTAssertFalse(content.includes("cat", "developer"))
    }
    
    func testIncludesWithCollection() 
    {
        let content = "The quick brown fox jumps over the lazy dog."
        let matchingWords = ["quick", "lazy"]
        XCTAssertTrue(content.includes(matchingWords))
        
        let nonMatchingWords = ["cat", "developer"]
        XCTAssertFalse(content.includes(nonMatchingWords))
    }

}
