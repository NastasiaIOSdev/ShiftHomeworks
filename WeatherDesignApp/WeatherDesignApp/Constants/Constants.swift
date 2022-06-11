//
//  Constants.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 04.06.2022.
//

import Foundation

struct Constants {
    static let apiKeyWeather = "1fbe35f21a364f7a9a384308220406"
    static let currentWeatherBaseURL = "https://api.weatherapi.com/v1/current.json?key="
    static let historyBaseURL = "https://api.weatherapi.com/v1/history.json?key="
    
    static let city = "Novosibirsk"
    static let date = "2022-06-9"
    
    static let weatherUrl = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(apiKeyWeather)&q=\(city)")
    
    static let historyURL = "https://api.weatherapi.com/v1/history.json?key=\(apiKeyWeather)&q=\(city)&dt=\(date)"
}
