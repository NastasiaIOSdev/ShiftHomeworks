//
//  WeatherDiaryRouter.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 29.05.2022.
//

import Foundation
import UIKit

protocol IWeatherDiaryRouter {
    func routeToNewNote()
    func routeToEditNote(forIndexPath: Int)
}

class  WeatherDiaryRouter {
    weak var vc: UIViewController?
}

extension  WeatherDiaryRouter: IWeatherDiaryRouter {
    func routeToNewNote() {
        let nextVC = WeatherNoteViewControllerAssembly.build()
        vc?.navigationController?.pushViewController(nextVC, animated: true)
        vc?.navigationController?.navigationBar.tintColor = .white
    }
    
    func routeToEditNote(forIndexPath: Int) {
        let vc = WeatherNoteViewController()
        vc.present(vc, animated: true)
    }
}
