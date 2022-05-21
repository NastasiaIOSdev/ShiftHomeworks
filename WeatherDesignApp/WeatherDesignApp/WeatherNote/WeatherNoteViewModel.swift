//
//  WeatherNoteViewModel.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import Foundation

struct WeatherNoteViewModel {
    let city: String?
    let date: Date?
    let weatherType: WeatherType?
    let temperature: Int?
    let additionalInfo: String?
}
