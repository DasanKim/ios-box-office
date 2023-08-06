//
//  TargetDate.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/08/06.
//

import Foundation

struct TargetDate {
    private let dayFromNow: Int
    private let dayToSecond: TimeInterval
    private let oneDayToSecond: Double = 86400
    private let dateFormatter = DateFormatter()
    
    init(dayFromNow: Int) {
        self.dayFromNow = dayFromNow
        self.dayToSecond = TimeInterval(dayFromNow) * oneDayToSecond
    }
    
    func formatByHypen() -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from:Date(timeIntervalSinceNow: dayToSecond))
    }
    
    func formatNoSeparator() -> String {
        dateFormatter.dateFormat = "yyyyMMdd"
        
        return dateFormatter.string(from: Date(timeIntervalSinceNow: dayToSecond))
    }
}
