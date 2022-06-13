//
//  WeatherService.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 10.06.2022.
//

import Foundation

class WeatherService {
    let weatherAPIKey: String
    let currentWeatherBaseURL: URL?
    let historyBaseURL: URL?
    var networkProcessor: NetworkProcessor?
    
    init() {
        self.weatherAPIKey = Constants.apiKeyWeather
        self.currentWeatherBaseURL = URL(string: Constants.currentWeatherBaseURL + weatherAPIKey)
        self.historyBaseURL = URL(string: Constants.historyBaseURL + weatherAPIKey)
        // + city + date
    }
    
    // MARK: - CurrentWeather
    
    func setNetworkProcessor(request networkRequest: String) {
        var request = networkRequest.trimmingCharacters(in: .whitespacesAndNewlines)
        request = networkRequest.replacingOccurrences(of: " ", with: "%20")
        if let url = URL(string: "\(self.currentWeatherBaseURL!)&q=\(request)") {
            self.networkProcessor = NetworkProcessor(url: url)
        }
    }
    
    func getLocation(_ location: String, completion: @escaping (Location?) -> Void) {
        setNetworkProcessor(request: location)
        networkProcessor?.downloadJSONFronURL({ (jsonDictionary) in
            if let weatherLocationDictionary = jsonDictionary?["location"] as? [String : Any] {
                let location = Location(dictionary: weatherLocationDictionary)
                completion(location)
            } else {
                completion(nil)
            }
        })
    }
    
    func getCurrentweather(_ location: String, completion: @escaping (CurrentWeather?) -> Void) {
        setNetworkProcessor(request: location)
        networkProcessor!.downloadJSONFronURL({ (jsonDictionary) in
            if let currentWeatherDictionary = jsonDictionary?["current"] as? [String : Any] {
                let currentWeather = CurrentWeather(dictionary: currentWeatherDictionary)
                completion(currentWeather)
            } else {
                completion(nil)
            }
        })
    }
    
    func getCondition(_ location: String, completion: @escaping (ConditionWeather?) -> Void) {
        setNetworkProcessor(request: location)
        networkProcessor!.downloadJSONFronURL({ (jsonDictionary) in
            if let currentDictionary = jsonDictionary?["current"] as? [String : Any] {
                if let conditionDictionary = currentDictionary["condition"] as? [String : Any] {
                    let condition = ConditionWeather(dictionary: conditionDictionary)
                    completion(condition)
                }
            } else {
                completion(nil)
            }
        })
    }
    
    // MARK: - History Weather
    
    func setNetworkProcessorHistory(request networkRequest: String) {
        var request = networkRequest.trimmingCharacters(in: .whitespacesAndNewlines)
        request = networkRequest.replacingOccurrences(of: " ", with: "%20")
        let startDate = DateConverter.getDateDaysAgo(daysAgo: -7)
        let currentDate = DateConverter.getDateDaysAgo(daysAgo: 0)
        if let url = URL(string: "\(self.historyBaseURL!)&q=\(request)&dt=\(startDate)&end_dt=\(currentDate)") {
            self.networkProcessor = NetworkProcessor(url: url)
        }
    }
    
    func getLocationHistort(_ location: String, completion: @escaping (Location?) -> Void) {
        setNetworkProcessorHistory(request: location)
        networkProcessor?.downloadJSONFronURL({ (jsonDictionary) in
            if let weatherLocationDictionary = jsonDictionary?["location"] as? [String : Any] {
                let location = Location(dictionary: weatherLocationDictionary)
                completion(location)
            } else {
                completion(nil)
            }
        })
    }
    
    func getHistortDay(_ location: String, completion: @escaping (HistoryForecastDay?) -> Void) {
        setNetworkProcessorHistory(request: location)
        networkProcessor!.downloadJSONFronURL({ (jsonDictionary) in
            if let forecastDictionary = jsonDictionary?["forecast"] as? [String : Any] {
                if let forecastDayDictionary = forecastDictionary["forecastday"] as? [String : Any] {
                    let forecatDay = HistoryForecastDay(dictionary: forecastDayDictionary)
                    completion(forecatDay)
                }
            } else {
                completion(nil)
            }
        })
    }
    
    func getHistoryTemperature(_ location: String, completion: @escaping (HistoryWeather?) -> Void) {
        setNetworkProcessorHistory(request: location)
        networkProcessor!.downloadJSONFronURL({ (jsonDictionary) in
            if let forecastDictionary = jsonDictionary?["forecast"] as? [String : Any] {
                if let forecastDayDictionary = forecastDictionary["forecastday"] as? [String : Any] {
                    if let dayDictionary = forecastDayDictionary["day"] as? [String : Any] {
                        let forecatDay = HistoryWeather(dictionary: dayDictionary)
                        completion(forecatDay)
                    }
                } else {
                    completion(nil)
                }
            }
        })
    }
    
    func getHistoryIcon(_ location: String, completion: @escaping (ConditionWeather?) -> Void) {
        setNetworkProcessorHistory(request: location)
        networkProcessor!.downloadJSONFronURL({ (jsonDictionary) in
            if let forecastDictionary = jsonDictionary?["forecast"] as? [String : Any] {
                if let forecastDayDictionary = forecastDictionary["forecastday"] as? [String : Any] {
                    if let dayDictionary = forecastDayDictionary["day"] as? [String : Any] {
                        if let conditionDictionary = dayDictionary["condition"] as? [String : Any] {
                            let condition = ConditionWeather(dictionary: conditionDictionary)
                            completion(condition)
                        }
                    } else {
                        completion(nil)
                    }
                }
            }
        })
    }
}
