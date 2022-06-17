//
//  HistoryWeatherDTO.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 13.06.2022.
//

import Foundation

struct HistoryWeatherDTO: Codable {
    let forecast: Forecast?
    let location: LocationCity?
}

struct Forecast: Codable {
    let forecastday: [Forecastday]?
}

struct Forecastday: Codable {
    let date: String?
    let day: Day?
}

struct Day: Codable {
    let tempC: Double?
    let condition: ConditionHistory?
    
    enum CodingKeys: String, CodingKey {
        case tempC = "avgtemp_c"
        case condition
    }
}

struct ConditionHistory: Codable {
    var icon: String?
}

struct LocationCity: Codable {
    let name: String?
}
