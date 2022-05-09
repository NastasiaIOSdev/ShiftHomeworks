//
//  AppFonts.swift
//  Homework-3
//
//  Created by Анастасия Ларина on 09.05.2022.
//

import UIKit

enum AppFonts {
    
    case light32
    case bold32
    
    var font: UIFont? {
        switch self {
        case .light32:
            return UIFont(name: "Montserrat-Light", size: 32)
        case .bold32:
            return UIFont(name: "Montserrat-Bold", size: 32)
        }
    }
}
