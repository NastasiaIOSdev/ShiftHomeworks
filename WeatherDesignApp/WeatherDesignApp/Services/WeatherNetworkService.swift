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
    
    func getCondition(_ location: String, completion: @escaping (Condition?) -> Void)
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
        var request = networkRequest.trimmingCharacters(in: .whitespacesAndNewlines)
        request = networkRequest.replacingOccurrences(of: " ", with: "%20")
        if let url = URL(string: "\(self.currentWeatherBaseUrl!)&q=\(request)") {
            self.networkProcessor = NetworkProcessor(url: url)
        }
    }
    
    func getLocation(_ location: String, completion: @escaping(Location?) -> Void) {
        setupNetworkProcessor(request: location)
        networkProcessor!.downLoadJSONFromUrl({ (jsonDictionary) in
            if let weatherLocationDictionary = jsonDictionary?["location"] as? [String : Any] {
                let location = Location(dictionary: weatherLocationDictionary)
                completion(location)
            } else {
                completion(nil)
            }
        })
    }
    
    func getCurrentWeather(_ location: String, completion: @escaping (CurrentWeather?) -> Void) {
        setupNetworkProcessor(request: location)
        networkProcessor!.downLoadJSONFromUrl({ (jsonDictionary) in
            if let currentWeatherDictionary = jsonDictionary?["current"] as? [String : Any] {
                print(currentWeatherDictionary)
                let currentWeather = CurrentWeather(dictionary: currentWeatherDictionary)
                completion(currentWeather)
            } else {
                completion(nil)
            }
        })
    }
    
    func getCondition(_ location: String, completion: @escaping (ConditionWeather?) -> Void) {
        setupNetworkProcessor(request: location)
        networkProcessor!.downLoadJSONFromUrl({ (jsonDictionary) in
            if let currentDictionary = jsonDictionary?["current"] as? [String : Any] {
                if let conditionDictionary = currentDictionary["condition"] as? [String : Any]
                {
                    let condition = ConditionWeather(dictionary: conditionDictionary)
                    completion(condition)
                }
            } else {
                completion(nil)
            }
        })
    }
}
