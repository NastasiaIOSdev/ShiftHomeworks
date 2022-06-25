//
//  CurrentWeatherViewModel.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import Foundation

protocol ICurrentWeatherViewModel {
    func requestCurrentWeather(for city: String?)
}

struct CurrentWeatherViewModel {
    let date: String
    let temp: String
    let text: String
    let wind: String
    let humidity: String
}

extension CurrentWeatherViewModel {
    init(from dtoModel: WeatherDTO) {
        guard
            let tempC = dtoModel.current?.tempC,
            let wind = dtoModel.current?.windKph,
            let text = dtoModel.current?.condition?.text,
            let humidity = dtoModel.current?.humidity else { assert(false) }
            
        self.date = Self.convertDate(Date.now)
        self.temp = String(tempC)
        self.wind = String(wind)
        self.humidity = String(humidity)
        self.text = String(text)
    }
}

private extension CurrentWeatherViewModel {
    static func convertDate(_ date: Date) -> String {
        return DateConverter.showDayWithWeekDay(date)
    }
}
