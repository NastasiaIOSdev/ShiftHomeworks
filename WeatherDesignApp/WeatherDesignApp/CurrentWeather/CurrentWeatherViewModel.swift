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
}
