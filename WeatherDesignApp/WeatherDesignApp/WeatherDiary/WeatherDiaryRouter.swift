//
//  WeatherDiaryRouter.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 29.05.2022.
//

import Foundation
import UIKit

protocol IWeatherDiaryRouter: AnyObject {
    func routeToNewNote(viewController: UIViewController)
    func routeToEditNote(fviewController: UIViewController)
}

final class  WeatherDiaryRouter {
    weak var vc: UIViewController?
}

extension  WeatherDiaryRouter: IWeatherDiaryRouter {
    func routeToNewNote(viewController: UIViewController) {
        let nextVC = WeatherNoteViewControllerAssembly.build()
        vc?.navigationController?.pushViewController(nextVC, animated: true)
        vc?.navigationController?.navigationBar.tintColor = .white
    }
    
    func routeToEditNote(fviewController viewController: UIViewController) {
        let vc = WeatherNoteViewController()
        vc.present(vc, animated: true)
    }
}
