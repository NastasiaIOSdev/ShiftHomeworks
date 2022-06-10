//
//  CurrentWeather.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 10.06.2022.
//

import Foundation


class CurrentWeather {
    let temp: Int?
    let wind: Int?
    let humidity: Int?
    
    init(dictionary: [String : Any]) {
        if  let tempDouble = dictionary["temp_c"] as? Double {
            temp = Int(tempDouble)
        } else {
            temp = nil
        }
        
        if let windDouble = dictionary["wind_kph"] as? Double {
            wind = Int(windDouble)
        } else {
            wind = nil
        }
        
        if let humidityDouble = dictionary["humidity"] as? Double {
            humidity = Int(humidityDouble)
        } else {
            humidity = nil
        }
    }
}
