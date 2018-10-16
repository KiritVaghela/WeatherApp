//
//  FiveDayForeCastData.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 17/10/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import Foundation
import ObjectMapper

class FiveDayForeCastData: BaseResponse {
    
    var cod:String?
    var message:Float?
    var cnt:Int?
    
    var weatherDataList:[WeatherData]?
    var coord:Coord?
    
    //mapping the json keys with properties
    public override func mapping(map: Map) {
        super.mapping(map: map)
        
        cod         <- map["cod"]
        message     <- map["message"]
        cnt         <- map["cnt"]
       
        weatherDataList <- map["list"]
        coord           <- map["coord"]

    }
}
