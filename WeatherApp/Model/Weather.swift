//
//  Weather.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 10/15/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import Foundation
import ObjectMapper

class Weather: Mappable {
    
    var id:Int = 0
    var main:String = ""
    var description:String = ""
    var icon:String = ""
    
    //MARK: - Object Mapper
    required init?(map: Map) {
        
    }
    
    //mapping the json keys with properties
    public func mapping(map: Map) {
        id          <- map["id"]
        main        <- map["main"]
        description <- map["description"]
        icon        <- map["icon"]
    }
    
}
