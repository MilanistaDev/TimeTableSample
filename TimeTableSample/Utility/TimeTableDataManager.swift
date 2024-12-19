//
//  TimeTableDataManager.swift
//  TimeTableSample
//
//  Created by Takuya Aso on 2024/12/19.
//

import Foundation

final class TimeTableDataManager {
    private let userDefaults = UserDefaults(suiteName: "group.com.ASTK.TimeTableSample")
    private let timeTableDataKey = "timeTableData"

    /// App Groups で時刻表のデータを共有できるように保存する
    /// - Parameters:
    ///   - timeTable: 時刻表データ
    ///   - completion: 完了処理用のクロージャ
    func storeTimeTableData(timeTable: [TimeTable], completion: (() -> Void)? = nil) throws {
        do {
            let data = try JSONEncoder().encode(timeTable)

            if let userDefaults = userDefaults {
                userDefaults.set(data, forKey: timeTableDataKey)
                completion?()
            }

        } catch {
            throw APIError.jsonEncode
        }
    }

    /// App Groups で共有している時刻表のデータを取得
    /// - Parameters:
    ///   - timeTable: 時刻表データ
    ///   - completion: 完了処理用のクロージャ
    func getTimeTableData(completion: (() -> Void)? = nil) throws -> [TimeTable] {
        do {
            if let userDefaults = userDefaults {
                if let data = userDefaults.object(forKey: timeTableDataKey) as? Data {
                    return try JSONDecoder().decode([TimeTable].self, from: data)
                } else {
                    throw APIError.noData
                }
            } else {
                throw APIError.appGroups
            }
        } catch {
            throw APIError.jsonDecode
        }
    }
}
