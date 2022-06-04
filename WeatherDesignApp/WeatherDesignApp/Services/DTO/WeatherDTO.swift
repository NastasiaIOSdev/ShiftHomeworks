//
//  WeatherDTO.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 04.06.2022.
//

import Foundation

struct WeatherDTO: Codable {
    let current: Current?
}

struct Current: Codable {
    let tempC: Int?
    let condition: Condition?
    let windKph: Double?
    let humidity: Int?
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
        case windKph = "wind_kph"
        case humidity
    }
}

struct Condition: Codable {
    let icon: String?
}
