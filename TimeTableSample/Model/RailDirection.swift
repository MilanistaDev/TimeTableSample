//
//  RailDirection.swift
//  TimeTableSample
//
//  Created by Takuya Aso on 2024/12/18.
//

/// 方面情報(銀座線は渋谷方面or浅草方面)
enum RailDirection: String, Decodable {
    case shibuya = "odpt.RailDirection:TokyoMetro.Shibuya"
    case asakusa = "odpt.RailDirection:TokyoMetro.Asakusa"
}
