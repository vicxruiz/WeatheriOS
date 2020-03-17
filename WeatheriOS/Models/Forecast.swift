//
//  Forecast.swift
//  WeatheriOS
//
//  Created by Victor Ruiz on 3/17/20.
//  Copyright © 2020 Victor Ruiz. All rights reserved.
//

import Foundation

struct Forecast: Codable {
    var forecasts: [ForecastDay]
    enum CodingKeys: String, CodingKey {
        case forecasts = "forecastday"
    }
}

struct ForecastDay: Codable {
    var date: String
    var day: Day
}

struct Day: Codable {
    var maxTemp: Int
    var minTemp: Int
    var avgTemp: Int
    var maxWind: Int
    var condition: Condition
}

struct Condition: Codable {
    var text: String
    var icon: String
}
