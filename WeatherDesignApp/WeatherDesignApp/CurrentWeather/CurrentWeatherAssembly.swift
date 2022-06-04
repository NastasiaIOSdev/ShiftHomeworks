//
//  CurrentWeatherAssembly.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import Foundation

enum CurrentWeatherAssembly {
    static func build() -> CurrentWeatherViewController {
        let router = CurrentWeatherRouter()
        let presenter = CurrentWeatherPresenter(router: router)
        let vc = CurrentWeatherViewController(presenter: presenter)
        return vc
    }
}

