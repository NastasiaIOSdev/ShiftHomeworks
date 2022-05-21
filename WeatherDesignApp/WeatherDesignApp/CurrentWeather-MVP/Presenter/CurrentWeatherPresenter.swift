//
//  CurrentWeatherPresenter.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import Foundation

protocol ICurrentWeatherPresenter: AnyObject {
    func viewDidLoad(ui: ICustomWeatherView)
}

final class CurrentWeatherPresenter: ICurrentWeatherPresenter {
    weak var ui: ICustomWeatherView?
    let model:  CurrentWeatherViewModel?
    
    init(model: CurrentWeatherViewModel) {
        self.model = model
    }
    func viewDidLoad(ui: ICustomWeatherView) {
        self.ui = ui
        self.ui?.buttonTappedHandler = {
          //self.present(WeatherNoteViewControllerAssembly.build(), animated: true)
        }
    }
}
