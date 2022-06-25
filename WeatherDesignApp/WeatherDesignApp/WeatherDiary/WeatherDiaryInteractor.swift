//
//  WeatherDiaryInteractor.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 28.05.2022.
//

import Foundation
import UIKit

protocol IWeatherDiaryInteractor: AnyObject {
    func fetchDataFromNetworkingService(forCity: String, completion: @escaping ([WeatherDiaryEntity]) -> Void)
}

final class WeatherDiaryInteractor {
    var networkService: INetworkservice?
}

// MARK: - IWeatherDiaryInteractor

extension WeatherDiaryInteractor: IWeatherDiaryInteractor {
    func fetchDataFromNetworkingService(forCity currentCity: String, completion: @escaping ([WeatherDiaryEntity]) -> Void) {
        
        guard let networkservice = networkService else { return }
        
        networkservice.loadHistoryWeatherData(city: currentCity) { (result: Result<HistoryWeatherDTO, Error>) in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                     var weatherDiary = WeatherDiary(from: model, city: currentCity)
                    
                    func loadIcons(completion: @escaping () -> Void) {
                        var counter = 0
                        for (index, entity) in weatherDiary.entities.enumerated() {
                            self.getImageDataFromUrl(url: entity.weatherImage, completion: { image in
                                counter += 1
                                weatherDiary.entities[index].icon = image
                                if counter == weatherDiary.entities.count {
                                    completion()
                                }
                            })
                        }
                    }
                    loadIcons {
                        completion(weatherDiary.entities)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Interactor: \(error.localizedDescription)")
                }
            }
        }
    }
    func getImageDataFromUrl(url: String?, completion: @escaping (UIImage?) -> Void) {
        guard let url = url else { return }
        self.networkService?.loadCurrentWeatherImage(urlString: url) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }
}
