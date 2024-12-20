//
//  RailDirection.swift
//  TimeTableSample
//
//  Created by Takuya Aso on 2024/12/18.
//

import Foundation

/// 方面情報(銀座線は渋谷方面or浅草方面)
enum RailDirection: String, Codable {
    case shibuya = "odpt.RailDirection:TokyoMetro.Shibuya"
    case asakusa = "odpt.RailDirection:TokyoMetro.Asakusa"

    var direction: String {
        switch self {
        case .shibuya:
            "渋谷方面"

        case .asakusa:
            "浅草方面"
        }
    }
}
