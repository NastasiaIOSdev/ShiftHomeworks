//
//  CustomUITabBarController.swift
//  Homework-3
//
//  Created by Анастасия Ларина on 05.05.2022.
//

import UIKit
import SnapKit

class CustomUITabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationTabBar()
        self.configureTabBarControllerColor()
    }
}

extension CustomUITabBarController {
    
    func configureTabBarControllerColor() {
        self.tabBar.barTintColor = .black
        self.tabBar.backgroundColor = .black
        self.tabBar.tintColor = .white
    }
    
    func configureNavigationTabBar() {
        let navigationFirstTab = generateNavigationTabBarController(viewController: AboutMeViewController(), title: "About me", image: UIImage(named: "mikkiField"))
        let navigationSecondTab = generateNavigationTabBarController(viewController: HardSkillsViewController(), title: "Hard skills", image: UIImage(named: "hardSkill"))
        let navigationThirdTab = generateNavigationTabBarController(viewController: SoftSkillsViewController(), title: "Soft skills",image: UIImage(named: "softSkill"))
        viewControllers = [navigationFirstTab, navigationSecondTab, navigationThirdTab]
    }
    
    fileprivate func generateNavigationTabBarController(viewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.title = title
        navigationController.tabBarItem.image = image
        return navigationController
    }
}

