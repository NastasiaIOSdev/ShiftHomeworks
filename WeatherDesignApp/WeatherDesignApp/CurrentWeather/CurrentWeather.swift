//
//  CurrentWeather.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 06.06.2022.
//

import Foundation

class CurrentWeather {
    let temp_c: Int?
    let humidity: Int?
    let wind_kph: String?
    
    init(dictionary: [String : Any]) {
        if let temp = dictionary["temp_c"] as? Double
        {
            temp_c = Int(temp)
        } else {
            temp_c = nil
        }
        
        if let hum = dictionary["humidity"] as? Double
        {
            humidity = Int(hum)
        } else {
            humidity = nil
        }
        
        if let wind = dictionary["wind_kph"] as? String
        {
            wind_kph = String(wind)
        } else {
            wind_kph = nil
        }
    }
}
