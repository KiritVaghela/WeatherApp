//
//  Wind.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 16/10/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import Foundation
import ObjectMapper

class Wind: Mappable {
    
    var speed:Float?
    var deg:Float?
    
    //MARK: - Object Mapper
    required init?(map: Map) {
        
    }
    
    //mapping the json keys with properties
    public func mapping(map: Map) {
        speed   <- map["speed"]
        deg     <- map["deg"]
        
  }
    
}
