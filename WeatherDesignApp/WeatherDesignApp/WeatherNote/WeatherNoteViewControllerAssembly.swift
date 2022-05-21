//
//  WeatherNoteViewControllerAssembly.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import UIKit

enum WeatherNoteViewControllerAssembly {
    static func build() -> WeatherNoteViewController {
        let weatherNoteVC = WeatherNoteViewController()
        return  weatherNoteVC
    }
}
