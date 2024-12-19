//
//  ContentView.swift
//  TimeTableSample
//
//  Created by Takuya Aso on 2024/12/09.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var selectedStation: SelectableStations?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 64.0) {
                    stationSelection()

                    timeTableGetButton()
                }
                .padding(.vertical, 64.0)
                .padding(.horizontal, 32.0)
            }
            .navigationTitle("時刻表取得")
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert(
            "時刻表取得・保存が完了しました。",
            isPresented: $viewModel.storeCompleted
        ) { }
    }
}

private extension ContentView {
    func stationSelection() -> some View {
        Menu {
            ForEach(SelectableStations.allCases, id: \.self) { station in
                Button {
                    selectedStation = station
                } label: {
                    Label {
                        Text(station.name)
                    } icon: {
                        station.icon
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
    }

    func timeTableGetButton() -> some View {
        Button {
            // 時刻表取得APIコール
            viewModel.didTapTimeTableFetch(targetStation: selectedStation!)
        } label: {
            Text("時刻表取得")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 44.0)
                .background(selectedStation == nil ? .gray.opacity(0.4) : .orange)
                .cornerRadius(8.0)
        }
        .disabled(selectedStation == nil)
    }
}

#Preview {
    ContentView()
}
