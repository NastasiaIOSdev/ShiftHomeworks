//
//  ConditionWeather.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 06.06.2022.
//

import Foundation
import UIKit

class ConditionWeather {
    let icon: String?
    let text: String?
    
    init(dictionary: [String : Any]) {
        if let icon = dictionary["icon"] as? String {
            self.icon = icon
        } else {
            self.icon = nil
        }
        if let text = dictionary["text"] as? String
        {
            self.text = text
        } else {
            self.text = nil
        }
    }
}
