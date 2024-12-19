//
//  ContentViewModel.swift
//  TimeTableSample
//
//  Created by Takuya Aso on 2024/12/18.
//

import Foundation

@MainActor
final class ContentViewModel: ObservableObject {
    @Published private(set) var timeTable: [TimeTable] = []
    @Published var storeCompleted = false

    private let timeTableAPI = TimeTableAPI()
    private let timeTableManager = TimeTableDataManager()

    func didTapTimeTableFetch(targetStation: SelectableStations) {
        fetchTimeTable(targetStation: targetStation)
    }
}

private extension ContentViewModel {
    /// 該当の駅時刻表を取得
    /// - Parameter targetStation: 時刻表を取得したい駅
    func fetchTimeTable(targetStation: SelectableStations) {
        Task {
            do {
                timeTable = try await timeTableAPI.fetchTimeTable(targetStation: targetStation)
                print(timeTable)

                // 取得したデータを保存して完了後にアラート表示
                try timeTableManager.storeTimeTableData(timeTable: timeTable) {
                    self.storeCompleted = true
                }

                // 保存できているかの確認コード
                // let storedData = try timeTableManager.getTimeTableData()
                // print(storedData)

            } catch {
                print(error)
            }
        }
    }
}
