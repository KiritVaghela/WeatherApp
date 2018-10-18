//
//  Clouds.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 16/10/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import ObjectMapper

class Clouds: Mappable, Codable {
    
    var all:Int?
    
    //MARK: - Object Mapper
    required init?(map: Map) {
        
    }
    
    //mapping the json keys with properties
    public func mapping(map: Map) {
        all   <- map["all"]
    }
    
}
