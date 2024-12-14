//
//  SelectableStations.swift
//  TimeTableSample
//
//  Created by Takuya Aso on 2024/12/14.
//

import SwiftUI

enum SelectableStations {
    case ginza
    case nihombashi

    var name: String {
        switch self {
        case .ginza:
            "銀座"

        case .nihombashi:
            "日本橋"
        }
    }

    var icon: Image {
        switch self {
        case .ginza:
            Image("G09")

        case .nihombashi:
            Image("G11")
        }
    }

    var identifier: String {
        switch self {
        case .ginza:
            "TokyoMetro.Ginza.Ginza"

        case .nihombashi:
            "TokyoMetro.Ginza.Nihombashi"
        }
    }
}
