//
//  WeatherApiManager.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 10/17/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import Foundation

class WeatherApiManager {
    
    // shared instance
    static let shared = WeatherApiManager()
    
    // private init method
    private init(){
        
    }
    
    // get weather data for provided latitude and longitude
    func getWeatherData(forLatitude lat:String, longitude lng:String, unitType units:String = "metric", success:@escaping (WeatherData) -> Void, failure:@escaping (Error) -> Void) {
        
        var params = [String:Any]()
        params["lat"] = lat
        params["lon"] = lng
        params["units"] = units
        
        NetworkManager.shared.makeObjectRequest(forClass: WeatherData.self, requestMethod: httpGet, forApi: "weather", params: params, success: { (response) in
            
            let responseObject = response.result.value!
            
            //check the response
            if response.response?.statusCode == 200 {
                success(responseObject)
            }else{
                failure(NSError(domain: keyDomain, code: responseObject.statusCode! , userInfo: [NSLocalizedDescriptionKey : responseObject.responseMessage]))
            }
            
        }) { (error) in
            
            failure(error)
        }
    }
    
    func getFiveDayForeCast(forLatitude lat:String, longitude lng:String, unitType units:String = "metric", success:@escaping (FiveDayForeCastData) -> Void, failure:@escaping (Error) -> Void) {
        
        var params = [String:Any]()
        params["lat"] = lat
        params["lon"] = lng
        params["units"] = units
        
        NetworkManager.shared.makeObjectRequest(forClass: FiveDayForeCastData.self, requestMethod: httpGet, forApi: "forecast", params: params, success: { (response) in
            
            let responseObject = response.result.value!
            
            //check the response
            if response.response?.statusCode == 200 {
                success(responseObject)
            }else{
                failure(NSError(domain: keyDomain, code: responseObject.statusCode! , userInfo: [NSLocalizedDescriptionKey : responseObject.responseMessage]))
            }
            
        }) { (error) in
            
            failure(error)
        }
        
    }
    
    
}
