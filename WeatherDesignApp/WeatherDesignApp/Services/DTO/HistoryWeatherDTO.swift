//
//  HistoryWeatherDTO.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 13.06.2022.
//

import Foundation

struct HistoryWeatherDTO: Codable {
    var forecast: Forecast?
}

struct Forecast: Codable {
    var forecastday: [Forecastday]?
}

struct Forecastday: Codable {
    var date: String?
    var day: Day?
}

struct Day: Codable {
    var tempC: Double?
    var condition: ConditionHistory?
    
    enum CodingKeys: String, CodingKey {
        case tempC = "avgtemp_c"
        case condition
    }
}

struct ConditionHistory: Codable {
    var icon: String?
}
