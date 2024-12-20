//
//  TimeTableSampleWidgets.swift
//  TimeTableSampleWidgets
//
//  Created by Takuya Aso on 2024/12/20.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> TimeTableEntry {
        TimeTableEntry(date: Date(), timeTable: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (TimeTableEntry) -> ()) {
        let entry = TimeTableEntry(date: Date(), timeTable: [])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [TimeTableEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()

        // FIXME: 0時過ぎの時刻表が取れない＆平日・土休日がズレる＆データの作りが急造

        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "HH:mm"
        dateFormmater.locale = Locale(identifier: "en_US_POSIX")

        // 今日が平日か土休日か
        let dayType: DayType = Calendar.current.isDateInWeekend(currentDate) ? .holidays : .weekdays

        do {
            // 平日か土休日かのデータをフィルタ
            let targetData = try TimeTableDataManager().getTimeTableData()
                .filter( { $0.dayType == dayType })

            // 15分ごとにデータを作ってタイムライン用の配列に格納
            for offset in 0 ..< 4 {
                let entryDate = Calendar.current.date(byAdding: .minute, value: 15 * offset, to: currentDate)!
                // 時刻表データでentryDateに近いものを最大3つピックアップ
                var filteredTimeTable: [TimeTable] = []
                for data in targetData {
                    let timeTable = data.timeTable.filter( { dateFormmater.date(from: $0.departureTime)! > dateFormmater.date(from: dateFormmater.string(from: entryDate))! }).prefix(3)
                    filteredTimeTable.append(TimeTable(station: data.station, railDirection: data.railDirection, dayType: data.dayType, timeTable: Array(timeTable)))
                }
                let entry = TimeTableEntry(date: entryDate, timeTable: filteredTimeTable)
                entries.append(entry)
            }

            // entries分の表示が終わったら再度タイムライン用のデータを作る
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)

        } catch {
            // TODO: エラーハンドリング
        }
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct TimeTableEntry: TimelineEntry {
    let date: Date
    let timeTable: [TimeTable]
}

struct TimeTableSampleWidgetsEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)
        }
    }
}

struct TimeTableSampleWidgets: Widget {
    let kind: String = "TimeTableSampleWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                TimeTableSampleWidgetsEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                TimeTableSampleWidgetsEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    TimeTableSampleWidgets()
} timeline: {
    TimeTableEntry(date: .now, timeTable: [])
    TimeTableEntry(date: .now, timeTable: [])
}
