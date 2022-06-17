//
//  URLConstants.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 17.06.2022.
//

import Foundation
import UIKit

enum  URLConstants {
    static func historyUrl(searchCity city: String) -> URL {
        let weatherAPIKey = URLQueryItem(name: "key", value: Constants.apiKeyWeather)
        let startDate = URLQueryItem(name: "dt", value: DateConverter.getDateDaysAgo(daysAgo: -7))
        let currentDate = URLQueryItem(name: "end_dt", value: DateConverter.getDateDaysAgo(daysAgo: 0))
        let city = URLQueryItem(name: "q", value: city)
        let queryItems = [ weatherAPIKey, startDate, currentDate, city ]
        var urlComponents = URLComponents(string: Constants.historyURL)
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else {assert(false, "Uncorrect URL")}
        return url
    }
}
