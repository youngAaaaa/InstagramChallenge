//
//  Date.swift
//  InstagraChallenge
//
//  Created by 안다영 on 2022/08/06.
//

import Foundation

extension Date {
    /**
     # currentTimeInMilli
     - Note: 현재 시간의 밀리초 반환
    */
    public static func currentTimeInMilli() -> Int {
        return Date().timeInMilli()
    }

    /**
     # timeInMilli
     - Note: timeIntervalSince1970의 밀리초 반환
    */
    public func timeInMilli() -> Int {
        return Int(self.timeIntervalSince1970 * 1000)
    }
}
