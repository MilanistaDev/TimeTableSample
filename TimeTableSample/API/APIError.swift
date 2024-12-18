//
//  APIError.swift
//  TimeTableSample
//
//  Created by Takuya Aso on 2024/12/18.
//

import Foundation

enum APIError: Error {
    case network
    case apiURL
    case response
    case noData
    case jsonDecode
    case statusCode(statusCode: String)
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .network:
            return "ネットワークエラーです。通信状態を確認してください。"

        case .apiURL:
            return "時刻表APIのURL生成時にエラーが発生しました。"

        case .response:
            return "内部エラーが発生しました。(response)"

        case .noData:
            return "内部エラーが発生しました。(data)"

        case .jsonDecode:
            return "内部エラーが発生しました。(パースエラー)"

        case .statusCode(let statusCode):
            return "内部エラーが発生しました。(\(statusCode))"
        }
    }
}
