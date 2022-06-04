//
//  CurrentWeatherViewModel.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import Foundation

struct CurrentWeatherViewModel {
    let date: String
    let temp: String
    let weatherType: Data?
    let wind: String
    let humidity: String
}

extension CurrentWeatherViewModel {
    init(from dtoModel: WeatherDTO) {
        guard
            let tempC = dtoModel.current?.tempC,
            let wind = dtoModel.current?.windKph,
            let humidity = dtoModel.current?.humidity else { assert(false) }
            
        self.date = Self.convertDate(Date.now)
        self.temp = String(tempC)
        self.weatherType = nil
        self.wind = String(wind)
        self.humidity = String(humidity)
    }
}

private extension CurrentWeatherViewModel {
    static func convertDate(_ date: Date) -> String {
        return DateConverter.showDayWithWeekDay(date)
    }

    static func convertTemperature(_ temperature: Int) -> String {
        let temperature = String(describing: Int.random(in: -20...30))
        return WeatherConverter.convertTemperature(temperature)
    }

    static func convertWind(_ wind: Int) -> String {
        let wind = String(describing: Int.random(in: 0...20))
        return WeatherConverter.convertWind(wind)
    }

    static func convertHumidity(_ humidity: Int) -> String {
        let humidity = String(describing: Int.random(in: 20...80))
        return WeatherConverter.convertHumidity(humidity)
    }
}
