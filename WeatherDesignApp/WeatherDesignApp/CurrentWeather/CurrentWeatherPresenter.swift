//
//  CurrentWeatherPresenter.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 21.05.2022.
//

import Foundation
import UIKit

protocol ICurrentWeatherPresenter: AnyObject {
    func viewDidLoad(ui: ICustomWeatherView, viewController: UIViewController)
}

final class CurrentWeatherPresenter{
    private weak var ui: ICustomWeatherView?
    private var router: ICurrentWeatherRouter?
    private var networkService = NetworkService()
    
    init(router: ICurrentWeatherRouter) {
        self.router = router
    }
}

extension CurrentWeatherPresenter: ICurrentWeatherPresenter {
    func viewDidLoad(ui: ICustomWeatherView, viewController: UIViewController) {
        self.ui = ui
        self.fetchDataFromNetworkingService()
        self.ui?.buttonTappedHandler = {
            self.router?.navToNextVC(viewController)
        }
    }
}

private extension CurrentWeatherPresenter {
    func fetchDataFromNetworkingService() {
        self.networkService.loadCurrentWeatherData { (result: Result<WeatherDTO, Error>) in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    let currentwetherViewModel = CurrentWeatherViewModel(from: model)
                    self.ui?.displayWeatherData(data: currentwetherViewModel)
                    self.getImageDataFromUrl(url: model.current?.condition?.icon)
                    
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Presenter: \(error.localizedDescription)")
                }
            }
        }
    }
    func getImageDataFromUrl(url: String?) {
        guard let url = url else { return }
        self.networkService.loadCurrentWeatherImage(urlString: url) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.ui?.setImage(imageData: data)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }
}
