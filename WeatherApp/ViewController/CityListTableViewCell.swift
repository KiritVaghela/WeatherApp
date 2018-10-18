//
//  CityListTableViewCell.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 17/10/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import UIKit

class CityListTableViewCell: UITableViewCell {

    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    
    var location:Location?
    var weatherData:WeatherData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setWeatherData(weatherData:WeatherData) {
        self.weatherData = weatherData
    }
    
    func updateUI() {
        if let city = location?.name {
            self.labelCityName.text = city
        }
        
        if let main = weatherData?.main, let _ = main.temp {
            self.labelTemp.text = "\(main.getTempeture())°"
        }
    }

}
