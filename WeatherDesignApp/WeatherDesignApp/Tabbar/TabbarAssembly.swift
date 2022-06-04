//
//  TabbarAssembly.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import UIKit

enum TabbarAssembly {
    
    static func build() -> UITabBarController {
        let tabBar = UITabBarController()
        let weatherViewController = CurrentWeatherAssembly.build()
        let weatheNavigationBar = UINavigationController(rootViewController: weatherViewController)
        let weatherDiaryViewController = WeatherDaiaryAssembly.build()
        let weatherNavDiaryViewController = UINavigationController(rootViewController: weatherDiaryViewController)
       
        tabBar.setViewControllers([weatheNavigationBar, weatherNavDiaryViewController], animated: true)
        
        weatherViewController.tabBarItem = UITabBarItem(title: "Current wether", image: UIImage(named: "sunnyTabbar"), tag: 0)
        weatherDiaryViewController.tabBarItem = UITabBarItem(title: "Wether diary", image: UIImage(named: "edit"), tag: 1)
        tabBar.tabBar.tintColor = .white
        tabBar.tabBar.unselectedItemTintColor = .black
        
        return tabBar
    }
}
