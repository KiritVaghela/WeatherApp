//
//  City.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 17/10/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import Foundation
import ObjectMapper

class City: Mappable {
    
    var id:Int?
    var name:String?
    var population: Int64?
    
    var coord: Coord?
    
    //MARK: - Object Mapper
    required init?(map: Map) {
        
    }
    
    //mapping the json keys with properties
    public func mapping(map: Map) {
        
        id          <- map["id"]
        name        <- map["main"]
        population  <- map["description"]
        
        coord       <- map["coord"]
    }
    
}
