//
//  ForeCastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 17/10/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import UIKit

class ForeCastCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var labelDateTime: UILabel!
    @IBOutlet weak var imageForecast: UIImageView!
    @IBOutlet weak var labelTemp: UILabel!
    
    func setForeCast(data:WeatherData, showFahreneit:Bool = false) {
        
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "h:mma"
        
        self.labelDateTime.text = dataFormatter.string(from: data.dt_text!)
        print(data.weather?.first?.main)
        self.imageForecast.image = UIImage.init(named: data.weather!.first!.main! + ".png")
        if showFahreneit {
            self.labelTemp.text = "\(data.main!.getFahrenheit())"
        }else{
            self.labelTemp.text = "\(data.main!.getCelsius())"
        }
    }
}
