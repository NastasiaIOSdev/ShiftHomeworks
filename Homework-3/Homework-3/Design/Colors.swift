//
//  Colors.swift
//  Homework-3
//
//  Created by Анастасия Ларина on 09.05.2022.
//

import class UIKit.UIColor

enum Colors {
    
    case pinkGrey
    
    var value: UIColor {
        switch self {
        case .pinkGrey:
            return UIColor(displayP3Red: 241/255, green: 221/255, blue: 201/255, alpha: 1)
        }
    }
}
