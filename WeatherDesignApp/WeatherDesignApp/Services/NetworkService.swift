//
//  NetworkService.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 04.06.2022.
//

import Foundation

protocol INetworkservice: AnyObject {
    func loadCurrentWeatherData<T: Codable>(completion: @escaping(Result<T, Error>) -> ())
    func loadSearchWeatherData<T:Codable>(with searchText: String, completion: @escaping (Result<T, Error>) -> ())
}

final class NetworkService {
    private enum EndPoint {
        static let weatherURL = "https://api.weatherapi.com/v1/history.json?"
    }
    
//    private enum QueryItem {
//        static let keyQuery =  NSURLQueryItem(name: "key", value: "1fbe35f21a364f7a9a384308220406")
//        static let dateQuery = NSURLQueryItem(name: "dt", value: DateConverter.getDateDaysAgo(daysAgo: -7))
//        static let endDateQuery = NSURLQueryItem(name: "end_dt", value: DateConverter.getDateDaysAgo(daysAgo: 0))
//    }
//
//    func weatherURL(with city: String) -> URL {
//        let queryItems = [
//            QueryItem.keyQuery,
//            QueryItem.dateQuery,
//            QueryItem.endDateQuery,
//            URLQueryItem(name: "q", value: city)
//        ]
//        var components = URLComponents(string: EndPoint.weatherURL)
//        components?.queryItems = queryItems
//        guard let url = components?.url else { assert(false, "Введен некорректный url!")}
//        return url
//    }
}

extension NetworkService: INetworkservice {
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
    
    func loadSearchWeatherData<T:Decodable>(with searchText: String, completion: @escaping (Result<T, Error>) -> ()) {
        guard !searchText.trimmingCharacters(in: .whitespaces) .isEmpty else { return }
        let urlString = Constants.historyURL + searchText
        guard let url = URL(string: urlString) else {
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
    
    }
