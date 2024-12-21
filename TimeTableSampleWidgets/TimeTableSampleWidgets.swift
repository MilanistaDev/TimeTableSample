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
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = TimeTableEntry(date: entryDate, timeTable: [])
            entries.append(entry)
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
