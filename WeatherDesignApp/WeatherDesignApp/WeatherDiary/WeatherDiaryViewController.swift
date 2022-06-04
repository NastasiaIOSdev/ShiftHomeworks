//
//  WeatherDiaryViewController.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import UIKit

final class WeatherDiaryViewController: UIViewController {
   
    var presenter: IWeatherDiaryPresenter?
    private var customView = WeatherDiaryView()
    
    init(title: String?,presenter: IWeatherDiaryPresenter) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
        self.title = title
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.customView
    }
    // MARK - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavBar()
        self.presenter?.viewDidload(ui: self.customView, viewController: self)
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
       // presenter?.routeToNewNote()
    }
}
