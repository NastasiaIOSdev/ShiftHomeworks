//
//  WeatherDiaryEntity.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 28.05.2022.
//

import Foundation
import UIKit

struct WeatherDiary {
    var entities: [WeatherDiaryEntity]
}

struct WeatherDiaryEntity {
    let town: String
    let date: String
    let weatherImage: String
    let temperature: String
    var icon: UIImage?
}

extension WeatherDiary {
    init(from dtoModel: HistoryWeatherDTO, city: String) {
        guard
            let forecast = dtoModel.forecast,
                let dayForecasts = forecast.dayForecasts
        else { assert(false)}
        
        var entities = [WeatherDiaryEntity]()
        
        for dayForecast in dayForecasts {
            guard
                let day = dayForecast.day,
                    let date = dayForecast.date
            else { assert(false) }
            
            guard
                let temp = day.tempC,
                    let condition = day.condition,
                    let icon = condition.icon
            else { assert(false) }
            
            let entity = WeatherDiaryEntity(town: city, date: date, weatherImage: icon, temperature: String(temp))
            entities.append(entity)
        }
        self.entities = entities
    }
}
