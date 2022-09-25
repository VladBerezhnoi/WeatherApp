//
//  WeatherModel.swift
//  Weather
//
//  Created by Vlad Berezhnoi on 14.05.2022.
//

import Foundation

struct WeatherModel: Codable {
    let currentConditions: CurrentConditions
    let address: String
}

struct CurrentConditions: Codable {
    let temp, feelslike, humidity: Double
    let cloudcover: Double
    let conditions: String
}



