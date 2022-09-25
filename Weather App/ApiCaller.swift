//
//  ApiCaller.swift
//  Weather
//
//  Created by Vlad Berezhnoi on 14.05.2022.
//

import Foundation
struct ApiCaller {
    
    static let shared = ApiCaller()

    struct Constants {
         static let city = "Kiev,Ukraine"
         static let baseURL = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/"
         static let API_key = "X4SK6ZHS3YTHGB7899FLDWWZV"
         static let include = "&include=current"
    }
    
    enum APIError: Error {
        case faileedToGetData
    }
    
    public func fetchWeather(city: String,
                             day: String,
                             completion: @escaping(Result<WeatherModel, Error>)-> Void) {
        guard let url = URL(string: "\(Constants.baseURL)\(city)\(day)\(Constants.API_key)\(Constants.include)") else {
            return
        }
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }
                
                do {
                    
                        let result = try JSONDecoder().decode(WeatherModel.self, from: data)
                        print(result)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                }
                catch {
                    DispatchQueue.main.async {
                        completion( .failure(error))
                    }
                }
            }
            task.resume()
        }
    }
