//
//  WeatherDiaryRouter.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 29.05.2022.
//

import Foundation
import UIKit

protocol IWeatherDiaryRouter: AnyObject {
    func routeToNewNote()
    func routeToEditNote(forIndexPath: Int)
}

final class  WeatherDiaryRouter {
    weak var vc: UIViewController?
}

extension  WeatherDiaryRouter: IWeatherDiaryRouter {
    func routeToNewNote() {
        let nextVC = WeatherNoteViewController()
        self.vc?.navigationController?.pushViewController(nextVC, animated: true)
        self.vc?.navigationController?.navigationBar.tintColor = .white
    }
    
    func routeToEditNote(forIndexPath: Int) {
        let vc = WeatherNoteViewController()
        self.vc?.present(vc, animated: true)
    }
}
