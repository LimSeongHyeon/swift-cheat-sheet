//
//  Date.swift
//
//
//  Created by TommyFuture on 11/20/24.
//

import Foundation


// MARK: - DATE
public extension String
{
    /// 문자열을 주어진 날짜 형식에 따라 `Date` 객체로 변환합니다.
    /// - Parameters:
    ///    - format: 시간/날짜 문자열의 형식을 나타내는 패턴. 기본값은 `"yyyy-MM-dd HH:mm:ss"`입니다.
    ///    - secondsFromGMT: 적용할 타임존의 GMT기준 초 입니다.  기본값은 대한민국(GMT +09)인 `9 * 60 * 60` 입니다.
    ///
    /// 
    /// - Returns: 형식에 맞는 `Date` 객체를 반환하며, 변환이 실패하면 `nil`을 반환합니다.
    ///
    ///
    /// - Usage:
    /// ```swift
    /// let dateString = "2023-10-04 14:23:45"
    /// let date = dateString.toDate()
    /// ```
    func toDate( _ format: String = "yyyy-MM-dd HH:mm:ss", secondsFromGMT: Int = 9 * 60 * 60) -> Date?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(secondsFromGMT: secondsFromGMT)
        return dateFormatter.date(from: self)
    }
}

