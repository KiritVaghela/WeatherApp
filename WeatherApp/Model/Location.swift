//
//  File.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 17/10/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import Foundation

class Location: Codable {
    
    var name:String
    var latitude:Double
    var longitude:Double
    
    var weatherData:WeatherData?
    
    init(name:String, latitude:Double, longitude:Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
