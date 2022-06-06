//
//  NetworkProcessor.swift
//  WeatherDesignApp
//
//  Created by Анастасия Ларина on 06.06.2022.
//

import Foundation

class NetworkProcessor {
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    let url: URL
    init(url: URL) {
        self.url = url
    }
    
    typealias JSONDictionaryHandelr = (([String : Any]?) -> Void)
    
    func downLoadJSONFromUrl(_ completion: @escaping JSONDictionaryHandelr) {
        let request = URLRequest(url: self.url)
        let dataTask = session.dataTask(with: request) { (data, responce, error) in
            if error == nil {
                if let httpResponse = responce as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200:
                        if let data = data {
                            print(data)
                            do {
                                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                                completion(jsonDictionary as? [String : Any])
                            } catch let error as NSError {
                                print("Error processing json data: \(error.localizedDescription)")
                            }
                        }
                    default:
                        print("HTTP Responce Code: \(httpResponse.statusCode)")
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
