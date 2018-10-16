//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 10/16/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherApp: Mappable {
    
    var coord:Coord?
    
    //MARK: - Object Mapper
    required init?(map: Map) {
        
    }
    
    //mapping the json keys with properties
    public func mapping(map: Map) {
        coord <- map["coord"]
    }
}
