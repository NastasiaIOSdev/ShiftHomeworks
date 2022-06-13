//
//  NetworkProcessor.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 10.06.2022.
//

import Foundation

class NetworkProcessor {
    
    lazy var configuretion: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuretion)
    let url: URL
    init(url: URL) {
        self.url = url
    }
    
    typealias JSONDictionaryHandler = (([String: Any]?) -> Void)
    
    func downloadJSONFronURL(_ completion: @escaping JSONDictionaryHandler) {
        let request = URLRequest(url: self.url)
        let dataTask = session.dataTask(with: request) { (data, responce, error) in
            if error == nil {
                if let httpResponse = responce as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                           case 200:
                        if let data = data {
                            do {
                                let jsomDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                                completion(jsomDictionary as? [String : Any])
                            } catch let error as NSError {
                                print("Error processing json data: \(error.localizedDescription)")
                            }
                        }
                    default: print("HTTP Response Code:\(httpResponse.statusCode)")
                        completion(nil)
                    }
                }
            }
            else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
        dataTask.resume()
    }
}
