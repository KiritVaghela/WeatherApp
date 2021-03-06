//
//  BaseReponse.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 10/17/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseResponse: Mappable, Codable {
    
    var statusCode:Int?
    var responseMessage: String?
    
    //MARK: - Object Mapper
    required init?(map: Map) {
        
    }
    
    //mapping the json keys with properties
    public func mapping(map: Map) {
        statusCode      <- map["cod"]
        responseMessage <- map["message"]
    }
}
