//
//  TrainType.swift
//  TimeTableSample
//
//  Created by Takuya Aso on 2024/12/18.
//

import Foundation

/// 列車種別(銀座線は各駅停車のみ)
enum TrainType: String, Codable {
    case local = "odpt.TrainType:TokyoMetro.Local"

    var name: String {
        switch self {
        case .local:
            "各駅停車"
        }
    }
}
