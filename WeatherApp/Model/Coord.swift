//
//  Coord.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 10/16/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import Foundation
import ObjectMapper

class Coord: Mappable {

    var lon:Int64?
    var lat:Int64?
    
    var weather:[Weather]?
    
    //MARK: - Object Mapper
    required init?(map: Map) {
        
    }
    
    //mapping the json keys with properties
    public func mapping(map: Map) {
        lon <- map["lon"]
        lat <- map["lat"]
        
        weather <- map["weather"]
    }
}
