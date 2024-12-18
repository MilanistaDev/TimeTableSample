//
//  TimeTable.swift
//  TimeTableSample
//
//  Created by Takuya Aso on 2024/12/18.
//

/// 時刻表API全体のレスポンスを受けるモデル
struct TimeTable: Decodable {
    var station: String
    var railDirection: RailDirection
    var dayType: DayType
    var timeTable: [TimeInfo]

    enum CodingKeys: String, CodingKey {
        case station = "odpt:station"
        case railDirection = "odpt:railDirection"
        case dayType = "odpt:calendar"
        case timeTable = "odpt:stationTimetableObject"
    }
}
