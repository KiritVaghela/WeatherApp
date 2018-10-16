//
//  Weather.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 10/15/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import RealmSwift

class Weather: Mappable {
    
    var status:Int = 0
    var error : String?
    var message: String = ""
    
    //MARK: - Object Mapper
    required init?(map: Map) {
        
    }
    
    //mapping the json keys with properties
    public func mapping(map: Map) {
        status  <- map["status"]
        error   <- map["error"]
        message <- map["message"]
    }
    
}
