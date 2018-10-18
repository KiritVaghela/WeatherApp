//
//  Main.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 16/10/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import Foundation
import ObjectMapper

class Main: Mappable {
    
    var temp:Float?
    var pressure:Float?
    var humidity: Int?
    var temp_min:Float?
    var temp_max:Float?
    var sea_level:Float?
    var grnd_level:Float?
    var temp_kf:Int?
    
    //MARK: - Object Mapper
    required init?(map: Map) {
        
    }
    
    //mapping the json keys with properties
    public func mapping(map: Map) {
        temp            <- map["temp"]
        pressure        <- map["pressure"]
        humidity        <- map["humidity"]
        temp_min        <- map["temp_min"]
        temp_max        <- map["temp_max"]
        sea_level       <- map["sea_level"]
        grnd_level      <- map["grnd_level"]
        temp_kf         <- map["temp_kf"]
    }
    
    func getTempeture() -> String {
        return String(Int(temp!))
    }
}
