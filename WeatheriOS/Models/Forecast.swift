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
    var maxTemp: Double
    var minTemp: Double
    var avgTemp: Double
    var maxWind: Double
    var condition: Condition
    enum CodingKeys: String, CodingKey {
        case maxTemp = "maxtemp_f"
        case minTemp = "mintemp_f"
        case avgTemp = "avgtemp_f"
        case maxWind = "maxwind_mph"
        case condition = "condition"
    }
}

struct Condition: Codable {
    var text: String
    var icon: String
}
