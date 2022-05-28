//
//  WeatherDiaryPresenter.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 28.05.2022.
//

import Foundation

protocol IWeatherDiaryPresenter: AnyObject {
    func viewDidload(ui: IWeatherDiaryView )
}

final class WeatherDiaryPresenter {
    private var ui: IWeatherDiaryView?
    private var delegate = WeatherDiaryViewDelegate()
}

extension WeatherDiaryPresenter: IWeatherDiaryPresenter {
    func viewDidload(ui: IWeatherDiaryView) {
        self.ui = ui
    }
    
    
}
