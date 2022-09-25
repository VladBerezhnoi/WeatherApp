//
//  WeatherService.swift
//  Weather
//
//  Created by Vlad Berezhnoi on 16.05.2022.
//

import Foundation
class WeatherManager {
    
    var city: String = "Sumy,Ukraine" {
        didSet {
            weatherDidChange?()
        }
    }
    private let day =  "/today?unitGroup=metric&key="     
    
    var weatherDidChange: (() -> Void)?
    
    func getWeatherInfo(completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        ApiCaller.shared.fetchWeather(city: city, day: day, completion: completion)
    }
}
