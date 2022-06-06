//
//  Constants.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 04.06.2022.
//

import Foundation

struct Constants {
    static let apiKeyWeather = "1fbe35f21a364f7a9a384308220406"
    static let city = "Novosibirsk"
    static let weatherUrl = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(apiKeyWeather)&q=\(city)&aqi=yes")
}
