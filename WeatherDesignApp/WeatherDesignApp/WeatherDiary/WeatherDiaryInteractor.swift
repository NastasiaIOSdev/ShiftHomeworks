//
//  WeatherDiaryInteractor.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 28.05.2022.
//

import Foundation
import UIKit

protocol IWeatherDiaryInteractor: AnyObject {
    func generateData(completion: @escaping ([WeatherDiaryEntity]) -> Void)
}

final class WeatherDiaryInteractor {
    var networkService: INetworkservice?
}

extension WeatherDiaryInteractor: IWeatherDiaryInteractor {
    func generateData(completion: @escaping ([WeatherDiaryEntity]) -> Void) {
        
        let town = randomCity()
        let date = convertDate(Date.now)
        let weatherImage = WeatherAsset(weatherType: WeatherType.allCases.randomElement() ?? .sunny)
        let temperature = convertTemperature(0)
        var entity = [WeatherDiaryEntity]()
        for i in 0...20 {
            entity.append(WeatherDiaryEntity(town: town, date: date, weatherImage: weatherImage, temperature: temperature))
        }
    }
}

private extension WeatherDiaryInteractor {
    func convertDate(_ date: Date) -> String {
        return DateConverter.showShortDay(date)
    }
    
    func convertTemperature(_ temperature: Int) -> String {
        let temperature = String(describing: Int.random(in: -20...30))
        return WeatherConverter.convertTemperature(temperature)
    }
    
    func randomCity() -> String {
        return ["Novosibirsk", "Tomsk", "St.Petersburg"].randomElement() ?? "Moscow"
    }
}
