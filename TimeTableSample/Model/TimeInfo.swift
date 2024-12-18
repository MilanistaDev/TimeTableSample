//
//  TimeInfo.swift
//  TimeTableSample
//
//  Created by Takuya Aso on 2024/12/18.
//

import Foundation

/// 時刻表の各時刻の情報
struct TimeInfo: Decodable, Hashable {
    /// 発車時刻
    var departureTime: String
    /// 列車種別
    var trainType: TrainType
    /// 運行番号
    var trainNumber: String
    /// 終点(どこ行きか)
    var destinationStation: [DestinationStation]
    /// 始発か
    var isOrigin: Bool?
    /// 最終電車か
    var isLast: Bool?

    enum CodingKeys: String, CodingKey {
        case departureTime = "odpt:departureTime"
        case trainType = "odpt:trainType"
        case trainNumber = "odpt:trainNumber"
        case destinationStation = "odpt:destinationStation"
        case isOrigin = "odpt:isOrigin"
        case isLast = "odpt:isLast"
    }
}
