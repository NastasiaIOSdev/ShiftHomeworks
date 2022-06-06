//
//  WeatherNetworkService.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 06.06.2022.
//

import Foundation

protocol IWeatherNetworkService {
    func getLocation(_ location: String, completion: @escaping(Location?) -> Void)
    
    func getCurrentWeather(_ location: String, completion: @escaping (CurrentWeatherViewModel?) -> Void)
    
    func getCondition(_ lovation: String, completion: @escaping (Condition?) -> Void)
}

final class WeatherNetworkService {
    private let weatherAPIKey: String
    private let currentWeatherBaseUrl: URL?
    private var networkProcessor: NetworkProcessor?
    
    init() {
        self.weatherAPIKey = ""
        self.currentWeatherBaseUrl = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(self.weatherAPIKey)")
    }
    
    func setupNetworkProcessor(request networkRequest: String) {
        
    }
    
    func getLocation(_ location: String, completion: @escaping(Location?) -> Void) {
        
    }
    
    func getCurrentWeather(_ location: String, completion: @escaping (CurrentWeatherViewModel?) -> Void) {
        
    }
    
    func getCondition(_ lovation: String, completion: @escaping (Condition?) -> Void) {
        
    }
}
