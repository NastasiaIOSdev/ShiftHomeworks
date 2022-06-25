//
//  WeatherDiaryAssembly.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import UIKit

enum WeatherDaiaryAssembly {
    static func build() -> WeatherDiaryViewController {
        let router = WeatherDiaryRouter()
        let interactor = WeatherDiaryInteractor()
        interactor.networkService = NetworkService()
        let presenter = WeatherDiaryPresenter(interactor: interactor, router: router)
        let vc = WeatherDiaryViewController(presenter: presenter)
        router.vc = vc
        return vc
    }
}
