//
//  Weather.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import Foundation
import UIKit

enum Weather: String, CaseIterable {
    case sunny
    case cloudy
    case showers
    case snow
    
    var image: UIImage? {
        switch self {
        case .sunny:
            return UIImage(named: "sunny")
        case .cloudy:
            return UIImage(named: "cloudy")
        case .showers:
            return UIImage(named: "showers")
        case .snow:
            return UIImage(named: "snow")
        }
    }
}
