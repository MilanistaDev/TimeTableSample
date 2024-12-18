//
//  TimeTableAPI.swift
//  TimeTableSample
//
//  Created by Takuya Aso on 2024/12/18.
//

import Foundation

final class TimeTableAPI {
    /// 駅時刻表APIをコールして時刻表データ取得
    /// - Parameter targetStation: 時刻表を取得したい駅
    /// - Returns: 取得できた時刻表データ
    func fetchTimeTable(targetStation: SelectableStations) async throws -> [TimeTable] {
        guard let apiUrl = generateAPIURL(targetStation: targetStation) else {
            // TODO: エラーハンドリング
            return []
        }

        let (data, response) = try await URLSession.shared.data(from: apiUrl)

        guard let httpResponse = response as? HTTPURLResponse else {
            // TODO: エラーハンドリング
            return []
        }

        switch httpResponse.statusCode {
        case 200:
            do {
                let timeTableData = try JSONDecoder().decode([TimeTable].self, from: data)
                return timeTableData

            } catch {
                // TODO: エラーハンドリング
                return []
            }

        default:
            // TODO: エラーハンドリング
            return []
        }
    }
}

private extension TimeTableAPI {
    /// 駅時刻表取得APIを叩くための URL を生成
    /// - Parameter targetStation: 時刻表を取得したい駅
    /// - Returns: 駅時刻表取得API を叩くための URL
    func generateAPIURL(targetStation: SelectableStations) -> URL? {
        let apiURLString = MetroTimeTableAPI.endpoint + APIQueries.main + targetStation.identifier + APIQueries.consumeKey
        return URL(string: apiURLString)
    }
}

struct MetroTimeTableAPI {
    static let endpoint = "https://api.odpt.org/api/v4/odpt:StationTimetable"
}

struct APIQueries {
    static let main = "?odpt:operator=odpt.Operator:TokyoMetro&odpt:station=odpt.Station:"
    static let consumeKey = "&acl:consumerKey=[取得したアクセストークン]"
}
