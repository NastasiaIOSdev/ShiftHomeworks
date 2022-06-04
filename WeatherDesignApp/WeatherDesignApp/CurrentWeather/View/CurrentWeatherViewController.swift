//
//  ViewController.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import UIKit

final class CurrentWeatherViewController: UIViewController {
    
    // MARK: - Properties
    
    private var presenter: ICurrentWeatherPresenter?
    private var ui = CustomWeatherView()
    
    init(presenter: ICurrentWeatherPresenter) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad(ui: self.ui)
    }
}
