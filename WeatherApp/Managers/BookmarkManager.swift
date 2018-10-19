//
//  BookmarkManager.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 17/10/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import Foundation

class BookmarkManager {
    
    // shared instance
    static let shared = BookmarkManager()
 
    private init(){
        
        if let locationData = UserDefaults.standard.data(forKey: "bookmarkLocations") {
            if let locationList = try? JSONDecoder().decode([Location].self, from: locationData) {
                bookmarkLocationList = locationList
            }
        }
    }
    
    private var bookmarkLocationList: [Location] = []
    
    func getLoctions() -> [Location] {
        return bookmarkLocationList
    }
    
    func addLoation(location:Location) {
        bookmarkLocationList.append(location)
        saveLocationList()
    }
    
    func removeLocation(location:Location) {

        let index = bookmarkLocationList.index(where: { (loc:Location) -> Bool in
            return (loc.latitude == location.latitude && loc.longitude == location.longitude)
        })
    
        if let index = index {
            bookmarkLocationList.remove(at: index)
            saveLocationList()
        }
    }
    
    private func saveLocationList(){
        
        // FIXME: App crash while saving location with weather data
        for location in bookmarkLocationList {
            location.weatherData = nil
        }
        
        if let locationData = try? JSONEncoder().encode(bookmarkLocationList) {
            UserDefaults.standard.set(locationData, forKey: "bookmarkLocations")
            UserDefaults.standard.synchronize()
        }
    }
}
