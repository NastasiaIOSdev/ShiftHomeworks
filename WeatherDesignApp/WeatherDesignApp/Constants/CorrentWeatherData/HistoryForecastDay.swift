//
//  HistoryForecastDay.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 13.06.2022.
//

import Foundation

class HistoryForecastDay {
    let date: String?
    
    init(dictionary: [String : Any]) {
        if let date = dictionary["date"] as? String {
            self.date = date
        } else {
            self.date = nil
        }
    }
}
