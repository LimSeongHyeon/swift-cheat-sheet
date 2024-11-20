//
//  File.swift
//  
//
//  Created by TommyFuture on 7/18/24.
//

import Foundation

// Properties
public extension Date
{
    /// 현재 날짜와 비교하여 문자열이 오늘인지 확인하는 연산 프로퍼티입니다.
    /// - Returns: 문자열이 오늘 날짜와 일치하면 `true`, 그렇지 않으면 `false`를 반환합니다.
    ///
    /// 이 프로퍼티는 문자열이 `Date` 타입인 경우에만 유효합니다. 현재 날짜의 연, 월, 일을 기준으로 비교합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let today = Date()
    /// print(today.isToday) // true
    ///
    /// let anotherDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    /// print(anotherDate.isToday) // false
    /// ```
    var isToday: Bool
    {
        let calendar = Calendar.current
        let currentDate = Date()
        
        guard calendar.component(.year, from: currentDate) == calendar.component(.year, from: self),
              calendar.component(.month, from: currentDate) == calendar.component(.month, from: self),
              calendar.component(.day, from: currentDate) == calendar.component(.day, from: self) else {return false}
        
        return true
    }
    
    
    /// 날짜의 시작 시간을 반환하는 계산 속성 (00:00:00).
    /// - Returns: 해당 날짜의 시작 시간을 포함한 `Date` 객체.
    ///
    /// - Usage:
    /// ```swift
    /// let today = Date()
    /// print(today.startOfDay) // 오늘의 00:00:00
    /// ```
    var startOfDay: Date { self.change(hour: 0, minute: 0, second: 0) }
    
    
    /// 날짜의 끝 시간을 반환하는 계산 속성 (23:59:59).
    /// - Returns: 해당 날짜의 끝 시간을 포함한 `Date` 객체.
    ///
    /// - Usage:
    /// ```swift
    /// let today = Date()
    /// print(today.endOfDay) // 오늘의 23:59:59
    /// ```
    var endOfDay: Date { self.change(hour: 23, minute: 59, second: 59) }
    
    
    /// 요일을 반환하는 계산 속성.
    /// - Returns: 해당 날짜의 요일을 정수 값으로 반환 (1: 일요일, 7: 토요일).
    ///
    /// - Usage:
    /// ```swift
    /// let today = Date()
    /// print(today.weekdayIndex) // 오늘의 요일
    /// ```
    var weekdayIndex: Int { Calendar.current.component(.weekday, from: self) }
    
    
    /// 해당 월의 첫째 날을 반환하는 계산 속성.
    /// - Returns: 해당 월의 첫째 날을 포함한 `Date` 객체.
    ///
    /// - Usage:
    /// ```swift
    /// let today = Date()
    /// print(today.firstDateOfMonth) // 해당 월의 첫째 날
    /// ```
    var firstDateOfMonth: Date
    {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)!
    }
    
    
    /// 해당 월의 첫째 날의 요일을 반환하는 계산 속성.
    /// - Returns: 해당 월의 첫째 날의 요일 (1: 일요일, 7: 토요일).
    ///
    /// - Usage:
    /// ```swift
    /// let today = Date()
    /// print(today.firstWeekdayOfMonth) // 해당 월 첫째 날의 요일
    /// ```
    var firstWeekdayOfMonth: Int
    {
        return Calendar.current.component(.weekday, from: self.firstDateOfMonth)
    }
}

// Format
public extension Date
{
    /// `Date` 객체를 주어진 형식으로 문자열로 변환합니다.
    /// - Parameter format: 변환할 날짜의 형식을 나타내는 패턴. 기본값은 `"yyyy-MM-dd HH:mm:ss"`입니다.
    /// - Returns: 주어진 형식으로 포맷팅된 날짜 문자열을 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let currentDate = Date()
    /// let dateString = currentDate.toString() // "2024-10-04 14:23:45"
    /// let customDateString = currentDate.toString("yyyy/MM/dd") // "2024/10/04"
    /// ```
    func toString(_ format: String = "yyyy-MM-dd HH:mm:ss") -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 9 * 3600)
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: self)
    }
}

// Check
public extension Date
{
    /// 날짜에서 지정된 `Calendar.Component`를 반환합니다.
    /// - Parameter component: 반환할 날짜 구성 요소 (`Calendar.Component`).
    /// - Returns: 요청한 날짜 구성 요소의 값을 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let today = Date()
    /// let year = today.component(.year) // 현재 연도
    /// let month = today.component(.month) // 현재 월
    /// ```
    func component(_ component: Calendar.Component) -> Int
    {
        let calendar = Calendar.current
        return calendar.component(component, from: self)
    }
    
    
    /// 두 날짜가 같은 연도와 월에 속하는지 확인합니다.
    /// - Parameter otherDate: 비교할 다른 날짜.
    /// - Returns: 두 날짜가 같은 연도와 월에 속하면 `true`, 그렇지 않으면 `false`를 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let date1 = "2024-10-04".toDate("yyyy-MM-dd")
    /// let date2 = date1.before(1, .month)
    /// let date3 = date1.before(1, .day)
    ///
    /// print(date1.isInSameMonth(with: date2)) // false (다른 달)
    /// print(date1.isInSameMonth(with: date3)) // true (같은 달)
    /// ```
    func isInSameMonth(with otherDate: Date) -> Bool
    {
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.year, .month], from: self)
        let components2 = calendar.dateComponents([.year, .month], from: otherDate)
        
        return components1.year == components2.year && components1.month == components2.month
    }
    
    
    /// 두 날짜 사이의 지정된 날짜 구성 요소 차이를 반환합니다.
    /// - Parameters:
    ///   - targetDate: 비교할 대상 날짜. `nil`이면 `nil`을 반환합니다.
    ///   - componentType: 비교할 날짜 구성 요소 세트 (기본값: [.day]).
    /// - Returns: 두 날짜 사이의 지정된 구성 요소 차이를 포함한 `DateComponents`를 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let today = Date()
    /// let anotherDate = Calendar.current.date(byAdding: .day, value: -10, to: today)
    /// if let dateDifference = today.between(and: anotherDate, componentType: [.day, .hour]) 
    /// {
    ///     print("Day difference: \(dateDifference.day!), Hour difference: \(dateDifference.hour!)")
    /// }
    /// ```
    func between(and targetDate: Date?, componentType: Set<Calendar.Component> = [.day]) -> DateComponents?
    {
        guard let targetDate = targetDate else { return nil }
        let calendar = Calendar.current
        return calendar.dateComponents(componentType, from: targetDate, to: self)
    }
    
    
    /// 주어진 날짜 구성 요소의 범위에서 특정 단위의 개수를 반환합니다.
    /// - Parameters:
    ///   - unit: 반환할 단위 (`Calendar.Component`).
    ///   - base: 단위를 계산할 기준 범위 (`Calendar.Component`).
    /// - Returns: 주어진 범위에서 단위의 개수를 반환합니다. 계산할 수 없으면 `nil`을 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let today = Date()
    ///
    /// if let daysInMonth = today.number(of: .day, in: .month)
    /// {
    ///     print("This month has \(daysInMonth) days.")
    /// }
    ///
    /// if let weeksInYear = today.number(of: .weekOfYear, in: .year)
    /// {
    ///     print("This year has \(weeksInYear) weeks.")
    /// }
    /// ```
    func number(of unit: Calendar.Component, in base: Calendar.Component) -> Int?
    {
        Calendar.current.range(of: unit, in: base, for: self)?.count
    }
}

// Edit
public extension Date
{
    /// 날짜에 지정된 값만큼 더한 날짜를 반환합니다.
    /// - Parameters:
    ///   - value: 더할 값.
    ///   - byAdding: 더할 기준이 되는 `Calendar.Component` (예: 일, 월, 년 등).
    /// - Returns: 값이 더해진 새로운 날짜를 반환합니다. 값이 0이면 원래 날짜를 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let today = Date()
    /// let oneWeekLater = today.after(7, .day) // 7일 후의 날짜
    /// let oneMonthLater = today.after(1, .month) // 1개월 후의 날짜
    /// ```
    func after( _ value: Int, _ byAdding: Calendar.Component) -> Date
    {
        if value == 0 { return self }
        let calendar = Calendar.current
        return calendar.date(byAdding: byAdding, value: value, to: self)!
    }
    
    
    /// 날짜에서 지정된 값만큼 뺀 날짜를 반환합니다.
    /// - Parameters:
    ///   - value: 뺄 값.
    ///   - byAdding: 뺄 기준이 되는 `Calendar.Component` (예: 일, 월, 년 등).
    /// - Returns: 값이 뺀 새로운 날짜를 반환합니다. 값이 0이면 원래 날짜를 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// let today = Date()
    /// let oneWeekAgo = today.before(7, .day) // 7일 전의 날짜
    /// let oneMonthAgo = today.before(1, .month) // 1개월 전의 날짜
    /// ```
    func before( _ value: Int, _ byAdding: Calendar.Component) -> Date
    {
        if value == 0 { return self }
        let calendar = Calendar.current
        return calendar.date(byAdding: byAdding, value: value * -1, to: self)!
    }
    

    /// 날짜의 연, 월, 일, 시, 분, 초를 변경하여 새로운 날짜를 반환합니다.
    /// - Parameters:
    ///   - year: 변경할 연도 (기본값: nil, 변경하지 않음).
    ///   - month: 변경할 월 (기본값: nil, 변경하지 않음).
    ///   - day: 변경할 일 (기본값: nil, 변경하지 않음).
    ///   - hour: 변경할 시 (기본값: nil, 변경하지 않음).
    ///   - minute: 변경할 분 (기본값: nil, 변경하지 않음).
    ///   - second: 변경할 초 (기본값: nil, 변경하지 않음).
    /// - Returns: 변경된 날짜를 반환하며, 변경하지 않은 부분은 원래 값이 유지됩니다.
    ///
    /// - Usage:
    /// ```swift
    /// let today = Date()
    /// let newDate = today.change(year: 2025, month: 12, day: 25) // 2025년 12월 25일로 변경
    /// let modifiedTime = today.change(hour: 9, minute: 30) // 시간만 09:30으로 변경
    /// ```
    func change(year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) -> Date
    {
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        dateComponents.year = year ?? dateComponents.year
        dateComponents.month = month ?? dateComponents.month
        dateComponents.day = day ?? dateComponents.day
        dateComponents.hour = hour ?? dateComponents.hour
        dateComponents.minute = minute ?? dateComponents.minute
        dateComponents.second = second ?? dateComponents.second
        return Calendar.current.date(from: dateComponents) ?? self
    }
}
