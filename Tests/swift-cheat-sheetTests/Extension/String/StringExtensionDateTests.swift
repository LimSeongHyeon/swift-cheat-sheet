//
//  StringExtensionDate.swift
//  
//
//  Created by TommyFuture on 11/20/24.
//

import XCTest

final class StringExtensionDate: XCTestCase 
{
    func testToDateWithValidDate() 
    {
        let dateString = "2023-10-04 14:23:45"
        let expectedDateComponents = DateComponents(
            calendar: Calendar(identifier: .gregorian),
            timeZone: TimeZone(secondsFromGMT: 9 * 60 * 60), year: 2023, month: 10, day: 4,
            hour: 14, minute: 23, second: 45
        )
        let expectedDate = expectedDateComponents.date
        XCTAssertEqual(dateString.toDate(), expectedDate)
    }
    
    func testToDateWithDifferentFormat() 
    {
        let dateString = "04-10-2023"
        let expectedDateComponents = DateComponents(
            calendar: Calendar(identifier: .gregorian),
            timeZone: TimeZone(secondsFromGMT: 9 * 60 * 60), year: 2023, month: 10, day: 4
        )
        let expectedDate = expectedDateComponents.date
        XCTAssertEqual(dateString.toDate("dd-MM-yyyy"), expectedDate)
    }
    
    func testToDateWithInvalidDate() 
    {
        let invalidDateString = "invalid-date"
        XCTAssertNil(invalidDateString.toDate())
    }
    
    func testToDateWithDifferentTimeZone() 
    {
        let dateString = "2023-10-04 05:23:45"
        let expectedDateComponents = DateComponents(
            calendar: Calendar(identifier: .gregorian),
            timeZone: TimeZone(secondsFromGMT: 0), year: 2023, month: 10, day: 4,
            hour: 5, minute: 23, second: 45
        )
        let expectedDate = expectedDateComponents.date
        XCTAssertEqual(dateString.toDate(secondsFromGMT: 0), expectedDate)
    }
    
    func testToDateWithEmptyString() 
    {
        let emptyString = ""
        XCTAssertNil(emptyString.toDate())
    }

}
