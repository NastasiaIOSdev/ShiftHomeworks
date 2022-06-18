//
//  CityManager.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 18.06.2022.
//

import Foundation

final class CityManager {
    
    private init() {}
    
    static let shared = CityManager()
    
    var currentCity: String?
}
