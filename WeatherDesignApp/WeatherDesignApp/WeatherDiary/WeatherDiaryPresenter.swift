//
//  WeatherDiaryPresenter.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 28.05.2022.
//

import Foundation
import UIKit

protocol IWeatherDiaryPresenter: AnyObject {
    func viewDidload(ui: IWeatherDiaryView, viewController: UIViewController)
    var routeToNewNote: (() -> ())? { get set }
}

final class WeatherDiaryPresenter {
    private weak var ui: IWeatherDiaryView?
    private var delegate = WeatherDiaryViewDelegate()
    private var interactor: IWeatherDiaryInteractor?
    private var router: IWeatherDiaryRouter?
    var routeToNewNote: (() -> ())?
    
    init(interactor: IWeatherDiaryInteractor, router: IWeatherDiaryRouter) {
        self.interactor = interactor
        self.router = router
    }
}

extension WeatherDiaryPresenter: IWeatherDiaryPresenter {
    func viewDidload(ui: IWeatherDiaryView, viewController: UIViewController) {
        self.ui = ui
        ui.getData(data: self.interactor?.generateData() ?? [])
        self.routeToNewNote = {
            self.router?.routeToNewNote(viewController: viewController)
        }
        ui.didSelectRowHandler = { [weak self] index in
            self?.router?.routeToEditNote(fviewController: viewController)
        }
    }
}
