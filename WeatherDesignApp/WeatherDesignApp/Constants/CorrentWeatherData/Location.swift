//
//  Location.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 10.06.2022.
//

import Foundation

class Location {
    let city: String?
    
    init(dictionary: [String : Any]) {
        if let city = dictionary["name"] as? String {
            self.city = city
        } else {
            self.city = nil
        }
    }
}
