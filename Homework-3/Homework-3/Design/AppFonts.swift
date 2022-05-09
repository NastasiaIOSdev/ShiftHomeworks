//
//  AppFonts.swift
//  Homework-3
//
//  Created by Анастасия Ларина on 09.05.2022.
//

import UIKit

enum AppFonts {
    
    case light16
    case light20
    case bold32
    
    var font: UIFont? {
        switch self {
        
        case .light16:
            return UIFont(name: "Montserrat-Light", size: 16)
        case .light20:
            return UIFont(name: "Montserrat-Light", size: 20)
        case .bold32:
            return UIFont(name: "Montserrat-Bold", size: 32)
        }
    }
}
