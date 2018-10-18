//
//  DayForeCast.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 18/10/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import Foundation

class DayForeCast: Codable {
    
    var date:String
    var main:[Main] = []
    
    var weatherData:WeatherData
    
    init(date:String, main:[Main], weatherData:WeatherData) {
        self.date = date
        self.main = main
        self.weatherData = weatherData
    }
}
