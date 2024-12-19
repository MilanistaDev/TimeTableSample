//
//  DestinationStation.swift
//  TimeTableSample
//
//  Created by Takuya Aso on 2024/12/18.
//

/// どこ行きかの終点情報(複数路線で該当駅がある場合があるのでケースを工夫)
enum DestinationStation: String, Codable {
    case shibuya = "odpt.Station:TokyoMetro.Ginza.Shibuya"
    case ueno = "odpt.Station:TokyoMetro.Ginza.Ueno"
    case asakusa = "odpt.Station:TokyoMetro.Ginza.Asakusa"
}
