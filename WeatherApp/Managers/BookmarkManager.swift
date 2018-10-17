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
    
    private func saveLocationList(){
        if let locationData = try? JSONEncoder().encode(bookmarkLocationList) {
            UserDefaults.standard.set(locationData, forKey: "bookmarkLocations")
            UserDefaults.standard.synchronize()
        }
    }
}
