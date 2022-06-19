//
//  NetworkService.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 04.06.2022.
//

import Foundation

protocol INetworkservice: AnyObject {
    func loadCurrentWeatherData<T: Decodable>(completion: @escaping(Result<T, Error>) -> ())
    func loadHistoryWeatherData<T: Decodable>(city: String, completion: @escaping (Result<T, Error>) -> Void)
    func loadCurrentWeatherImage(urlString: String, completion: @escaping(Result<Data, Error>) -> ())
}

final class NetworkService {
}

extension NetworkService: INetworkservice {
    
    func loadHistoryWeatherData<T: Decodable>(city: String, completion: @escaping (Result<T, Error>) -> Void) {
            let url = URLConstants.historyUrl(searchCity: city)
            
            let request = URLRequest(url: url)
            
                URLSession.shared.dataTask(with: request) { data, responce, error in
                    if let error = error {
                        completion(.failure(error))
                    }
                    guard let data = data else { return }
                    print("Получены данные о истории \(data)")
                    do {
                        let newData = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(newData))
                    }
                    catch let error {
                        completion(.failure(error))
                    }
                }.resume()
            }
    
    func loadCurrentWeatherData<T:Decodable>(completion: @escaping (Result<T, Error>) -> ()) {
        guard let url = Constants.weatherUrl else {
            assert(false) }
        
        let request = URLRequest(url: url)
        
            URLSession.shared.dataTask(with: request) { data, responce, error in
                if let error = error {
                    completion(.failure(error))
                }
                guard let data = data else { return }
                print(data)
                do {
                    let newData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(newData))
                }
                catch let error {
                    completion(.failure(error))
                }
            }.resume()
        }
        
        func loadCurrentWeatherImage(urlString: String, completion: @escaping(Result<Data, Error>) -> ()) {
            let correctUrlString = "https:"+urlString
            guard let url = URL(string: correctUrlString) else { return }
            let request = URLRequest(url: url)
            URLSession.shared.downloadTask(with: request) { url, responce, error in
                if let error = error {
                    completion(.failure(error))
                }
                guard let url = url else { return }
                if let data = try? Data(contentsOf: url) {
                    completion(.success(data))
                }
            }.resume()
        }
    }
