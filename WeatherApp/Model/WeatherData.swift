//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 10/16/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherData: Mappable {
    
    var id:Int64!
    var name:String!
    var cod:Int!
    var dt:Int64!
    var base:String!
    
    var weather:[Weather]?
    var coord:Coord?
    var main:Main?
    var wind:Wind?
    var clouds:Clouds?
    var sys:Sys?
    
    //MARK: - Object Mapper
    required init?(map: Map) {
        
    }
    
    //mapping the json keys with properties
    public func mapping(map: Map) {
        
        id      <- map["id"]
        name    <- map["name"]
        cod     <- map["cod"]
        dt      <- map["dt"]
        base    <- map["base"]
        
        weather <- map["weather"]
        coord   <- map["coord"]
        main    <- map["main"]
        wind    <- map["Wind"]
        clouds  <- map["clouds"]
        wind    <- map["wind"]
        sys     <- map["sys"]
        
    }
}
