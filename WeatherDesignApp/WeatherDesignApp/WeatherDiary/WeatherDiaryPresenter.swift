//
//  WeatherDiaryPresenter.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 28.05.2022.
//

import Foundation

protocol IWeatherDiaryPresenter: AnyObject {
    func viewDidload(ui: IWeatherDiaryView )
    func routeToNewNote()
}

final class WeatherDiaryPresenter {
    private weak var ui: IWeatherDiaryView?
    private var delegate = WeatherDiaryViewDelegate()
    private var interactor: IWeatherDiaryInteractor?
    private var router: IWeatherDiaryRouter?
    
    init(interactor: IWeatherDiaryInteractor, router: IWeatherDiaryRouter) {
        self.interactor = interactor
        self.router = router
    }
}

extension WeatherDiaryPresenter: IWeatherDiaryPresenter {
    func viewDidload(ui: IWeatherDiaryView) {
        let data: [WeatherDiaryEntity]?
        self.ui = ui
        data = self.interactor?.generateData()
        if let data = data {
            self.ui?.getData(data: data)
        }
        delegate.delegate = { [weak self] index in
            guard let self = self else { return }
            self.router?.routeToEditNote(forIndexPath: index)
        }
    }
    
    func routeToNewNote() {
        router?.routeToNewNote()
    }
}
