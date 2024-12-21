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
        VStack(spacing: .zero) {
            HStack(spacing: 8.0) {
                entry.timeTable.first?.station.icon
                    .frame(width: 36.0, height: 36.0)

                Text(entry.timeTable.first?.station.name ?? "--")
                    .font(.headline)
                    .foregroundStyle(.white)
            }
            .padding(.bottom, 4.0)

            HStack(spacing: .zero) {
                ForEach(entry.timeTable, id: \.railDirection) { data in
                    VStack(alignment: .leading, spacing: .zero) {
                        Text(data.railDirection.direction)
                            .font(.footnote)
                            .bold()
                            .foregroundStyle(.white)
                            .padding(.leading, 8.0)
                            .padding(.bottom, 4.0)

                        ForEach(data.timeTable, id: \.trainNumber) { timeInfo in
                            HStack(spacing: 4.0) {
                                Text(timeInfo.departureTime)
                                    .font(.caption)
                                    .bold()
                                    .monospacedDigit()
                                    .foregroundStyle(.white)
                                    .padding(.leading, 2.0)

                                Text(timeInfo.trainType.name)
                                    .frame(width: 20.0, height: 20.0)
                                    .font(.caption2)
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.1)
                                    .foregroundStyle(.white)

                                timeInfo.destinationStation.first?.icon
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20.0, height: 20.0)

                                Text(timeInfo.destinationStation.first?.destination ?? "--")
                                    .font(.caption)
                                    .bold()
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .minimumScaleFactor(0.1)
                            }
                        }
                        .padding(.horizontal, 4.0)
                        .padding(.vertical, 2.0)
                        .background(.black)
                    }
                }
            }

            Spacer()
        }
        .padding(.all, 16.0)
        .frame(maxWidth: .infinity)
        .background(Color("navyBlue"))
        .overlay(alignment: .topTrailing) {
            Text(entry.timeTable.first?.dayType.name ?? "--")
                .font(.caption2)
                .foregroundStyle(.white)
                .padding(.all, 4.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 4.0)
                        .stroke(.white, lineWidth: 1.0)
                )
                .padding(.all, 20.0)
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
        .contentMarginsDisabled()
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("Time Table")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    TimeTableSampleWidgets()
} timeline: {
    TimeTableEntry(date: .now, timeTable: [])
    TimeTableEntry(date: .now, timeTable: [])
}
