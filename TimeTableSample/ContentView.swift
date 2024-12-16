//
//  ContentView.swift
//  TimeTableSample
//
//  Created by Takuya Aso on 2024/12/09.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedStation: SelectableStations?

    var body: some View {
        NavigationStack {
            ScrollView {
                Menu {
                    ForEach(SelectableStations.allCases, id: \.self) { station in
                        Button {
                            selectedStation = station
                        } label: {
                            HStack {
                                station.icon

                                Text(station.name)
                            }
                        }
                    }

                } label: {
                    if let selectedStation = selectedStation {
                        HStack {
                            selectedStation.icon
                                .resizable()
                                .scaledToFit()
                                .frame(width: 36.0, height: 36.0)

                            Text(selectedStation.name)
                                .font(.title2)
                                .bold()
                        }
                    } else {
                        Text("時刻表を取得したい駅を選択")
                            .foregroundStyle(.blue)
                    }
                }
                .tint(.black)
                .padding(.vertical, 64.0)
            }
            .navigationTitle("時刻表取得")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
