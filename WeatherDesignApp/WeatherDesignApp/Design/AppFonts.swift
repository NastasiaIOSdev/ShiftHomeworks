//
//  AppFonts.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import Foundation
import UIKit

enum AppFonts {
    
    case light18
    case regular10
    case regular16
    case regular18
    case regular20
    case regular100
    case bold24
    case bold28
    
    var font: UIFont? {
        switch self {
        case .light18:
            return UIFont(name: "Overpass-Light", size: 18)
        case .regular10:
            return UIFont(name: "Overpass-Regular", size: 10)
        case .regular16:
            return UIFont(name: "Overpass-Regular", size: 16)
        case .regular18:
            return UIFont(name: "Overpass-Regular", size: 18)
        case .regular20:
            return UIFont(name: "Overpass-Regular", size: 20)
        case .regular100:
            return UIFont(name: "Overpass-Regular", size: 100)
        case .bold24:
            return UIFont(name: "Overpass-Bold", size: 24)
        case .bold28:
            return UIFont(name: "Overpass-Bold", size: 28)
        }
    }
}
