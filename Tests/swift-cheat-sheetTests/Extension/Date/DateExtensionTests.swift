//
//  DateExtensionTests.swift
//  
//
//  Created by TommyFuture on 11/20/24.
//

import XCTest

final class DateExtensionTests: XCTestCase 
{
    func testIsToday() 
    {
        XCTAssertTrue(Date().isToday)
        
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        XCTAssertFalse(yesterday.isToday)
    }
    
    func testStartOfDay() 
    {
        let today = Date()
        let start = today.startOfDay
        XCTAssertEqual(Calendar.current.component(.hour, from: start), 0)
        XCTAssertEqual(Calendar.current.component(.minute, from: start), 0)
        XCTAssertEqual(Calendar.current.component(.second, from: start), 0)
    }
    
    func testEndOfDay() 
    {
        let today = Date()
        let end = today.endOfDay
        XCTAssertEqual(Calendar.current.component(.hour, from: end), 23)
        XCTAssertEqual(Calendar.current.component(.minute, from: end), 59)
        XCTAssertEqual(Calendar.current.component(.second, from: end), 59)
    }
    
    func testWeekdayIndex() 
    {
        let today = Date()
        XCTAssertGreaterThanOrEqual(today.weekdayIndex, 1)
        XCTAssertLessThanOrEqual(today.weekdayIndex, 7)
    }
    
    func testFirstDateOfMonth() 
    {
        let today = Date()
        let firstDate = today.firstDateOfMonth
        XCTAssertEqual(Calendar.current.component(.day, from: firstDate), 1)
    }
    
    func testFirstWeekdayOfMonth() 
    {
        let today = Date()
        let firstWeekday = today.firstWeekdayOfMonth
        XCTAssertGreaterThanOrEqual(firstWeekday, 1)
        XCTAssertLessThanOrEqual(firstWeekday, 7)
    }
    
    func testToString() 
    {
        let date = Date(timeIntervalSince1970: 0) // 1970-01-01 00:00:00 UTC
        XCTAssertEqual(date.toString("yyyy-MM-dd"), "1970-01-01")
    }
    
    func testComponent() 
    {
        let today = Date()
        XCTAssertEqual(today.component(.year), Calendar.current.component(.year, from: today))
    }
    
    func testIsInSameMonth() 
    {
        let today = Date()
        let sameMonth = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        XCTAssertTrue(today.isInSameMonth(with: sameMonth))
        
        let differentMonth = Calendar.current.date(byAdding: .month, value: -1, to: today)!
        XCTAssertFalse(today.isInSameMonth(with: differentMonth))
    }
    
    func testBetween() 
    {
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let difference = today.between(and: yesterday, componentType: [.day])
        XCTAssertEqual(difference?.day, 1)
    }
    
    func testNumberOf() 
    {
        let today = Date()
        if let daysInMonth = today.number(of: .day, in: .month) 
        {
            XCTAssertGreaterThan(daysInMonth, 27)
            XCTAssertLessThanOrEqual(daysInMonth, 31)
        } 
        else
        {
            XCTFail("Failed to get number of days in the month")
        }
    }
    
    func testAfter() 
    {
        let today = Date()
        let oneWeekLater = today.after(7, .day)
        XCTAssertEqual(Calendar.current.date(byAdding: .day, value: 7, to: today), oneWeekLater)
    }
    
    
    func testBefore() 
    {
        let today = Date()
        let oneWeekAgo = today.before(7, .day)
        XCTAssertEqual(Calendar.current.date(byAdding: .day, value: -7, to: today), oneWeekAgo)
    }
    
    
    func testChange() 
    {
        let today = Date()
        let changedDate = today.change(year: 2025, month: 12, day: 25)
        XCTAssertEqual(changedDate.component(.year), 2025)
        XCTAssertEqual(changedDate.component(.month), 12)
        XCTAssertEqual(changedDate.component(.day), 25)
    }
}
