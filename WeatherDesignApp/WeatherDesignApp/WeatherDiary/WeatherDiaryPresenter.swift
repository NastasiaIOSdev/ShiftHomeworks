//
//  WeatherDiaryPresenter.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 28.05.2022.
//

import Foundation

protocol IWeatherDiaryPresenter: AnyObject {
    func viewDidload(ui: IWeatherDiaryView, city: String)
}

final class WeatherDiaryPresenter {
    private weak var ui: IWeatherDiaryView?
    private var interactor: IWeatherDiaryInteractor?
    private var router: IWeatherDiaryRouter?
    
    init(interactor: IWeatherDiaryInteractor, router: IWeatherDiaryRouter) {
        self.interactor = interactor
        self.router = router
    }
}

extension WeatherDiaryPresenter: IWeatherDiaryPresenter {
    func viewDidload(ui: IWeatherDiaryView, city: String) {

        self.ui = ui
        self.interactor?.fetchDataFromNetworkingService(forCity: city, completion: { data in
            self.ui?.setData(data: data)
        })
     
        ui.delegate.delegate = { [weak self] index in
            guard let self = self else { return }
            self.router?.routeToEditNote(forIndexPath: index)
        }
        
        ui.didSelectRowHandler = {
            self.router?.routeToNewNote()
        }
    }
}
