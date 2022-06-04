//
//  Builder.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 04.06.2022.
//

import UIKit

protocol Builder: AnyObject {
    func build() -> UIViewController
}
