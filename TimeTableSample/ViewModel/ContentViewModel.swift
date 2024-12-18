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

    private let timeTableAPI = TimeTableAPI()

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

            } catch {
                print(error)
            }
        }
    }
}
