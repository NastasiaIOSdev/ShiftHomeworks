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

extension WeatherDiaryInteractor: IWeatherDiaryInteractor {
    func fetchDataFromNetworkingService(forCity currentCity: String, completion: @escaping ([WeatherDiaryEntity]) -> Void) {
        guard let networkservice = networkService else { return }
        networkservice.loadHistoryWeatherData(city: currentCity) { (result: Result<HistoryWeatherDTO, Error>) in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                     var weatherDiary = WeatherDiary(from: model, city: currentCity)
                    
                    //self.getImageDataFromUrl(url: model.current?.condition?.icon)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Interactor: \(error.localizedDescription)")
                }
            }
        }
        
        }
}
