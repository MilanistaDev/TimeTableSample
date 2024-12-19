//
//  DayType.swift
//  TimeTableSample
//
//  Created by Takuya Aso on 2024/12/18.
//

import Foundation

/// 日付タイプ(平日or休日)
enum DayType: String, Codable, CaseIterable {
    case weekdays = "odpt.Calendar:Weekday"
    case holidays = "odpt.Calendar:SaturdayHoliday"
    
    var name: String {
        switch self {
        case .weekdays:
            "平日"
            
        case .holidays:
            "土休日"
        }
    }
}
