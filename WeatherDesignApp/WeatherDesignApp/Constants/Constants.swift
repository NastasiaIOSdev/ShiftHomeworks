//
//  Constants.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 04.06.2022.
//

import Foundation

struct Constants {
    static let apiKeyWeather = "1fbe35f21a364f7a9a384308220406"
    static let city = "Bali"
    static let zipCode = "07112"
    static let weatherUrl = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(apiKeyWeather)&q=\(city)")
    static let searchUrl = "http://api.weatherapi.com/v1/search.json?key=\(apiKeyWeather)&q="
    static let forecast7URL = "http://api.weatherapi.com/v1/forecast.json?key=\(apiKeyWeather)&q=\(zipCode)&days=7"
}
