//
//  WeatherDiaryViewController.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import UIKit

final class WeatherDiaryViewController: UIViewController {

// MARK: - Properties
    
    private var presenter: IWeatherDiaryPresenter?
    private var customView = WeatherDiaryView()
    private var cityManager = CityManager.shared
    
// MARK: - Init
    
    init(presenter: IWeatherDiaryPresenter) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - loadView
    
    override func loadView() {
        self.view = self.customView
    }
    
// MARK - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavBar()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let city = cityManager.currentCity else { return }
        presenter?.viewDidload(ui: customView, city: city)
    }
}

// MARK - Navigation

private extension WeatherDiaryViewController {
    func setupNavBar() {
        let image = UIImage(named: "edit")
        let uiBArButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.onNewNoteButtonPressed))
        uiBArButtonItem.tintColor = .white
        self.navigationItem.setRightBarButton(uiBArButtonItem, animated: true)
    }
    
    @objc
    func onNewNoteButtonPressed() {
        customView.didSelectRowHandler?()
    }
}
