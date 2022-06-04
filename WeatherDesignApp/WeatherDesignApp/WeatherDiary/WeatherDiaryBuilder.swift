//
//  WeatherDiaryAssembly.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import UIKit

final class WeatherDiaryBuilder {
    var title: String?
    
    func settitle(_ title: String) -> WeatherDiaryBuilder {
        self.title = title
        return self
    }
}

extension WeatherDiaryBuilder: Builder {
    func build() -> UIViewController {
        let title = self.title
        let router = WeatherDiaryRouter()
        let interactor = WeatherDiaryInteractor()
        let presenter = WeatherDiaryPresenter(interactor: interactor, router: router)
        let vc = WeatherDiaryViewController(title: title, presenter: presenter)
        return vc
    }
}
