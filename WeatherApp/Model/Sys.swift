//
//  Sys.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 16/10/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import Foundation
import ObjectMapper

class Sys: Mappable {
    
    var message:Float!
    var sunrise:Int64!
    var sunset:Int64!
    
    //MARK: - Object Mapper
    required init?(map: Map) {
        
    }
    
    //mapping the json keys with properties
    public func mapping(map: Map) {
        message   <- map["message"]
        sunrise   <- map["sunrise"]
        sunset    <- map["sunrise"]
    }
    
}
