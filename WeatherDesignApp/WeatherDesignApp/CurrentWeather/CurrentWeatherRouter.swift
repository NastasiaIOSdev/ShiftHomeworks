//
//  CurrentWeatherRouter.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 04.06.2022.
//

import UIKit

protocol ICurrentWeatherRouter: AnyObject {
    func navToNextVC(_ vc: UIViewController)
}

final class CurrentWeatherRouter { }

extension CurrentWeatherRouter: ICurrentWeatherRouter {
    func navToNextVC(_ vc: UIViewController) {
        vc.present(WeatherNoteViewController(), animated: true)
    }
}
