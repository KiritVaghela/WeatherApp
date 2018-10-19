//
//  DayForeCastTableCell.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 18/10/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import UIKit

class DayForeCastTableCell: UITableViewCell {

    
    @IBOutlet weak var labelDayName: UILabel!
    @IBOutlet weak var imageForeCast: UIImageView!
    @IBOutlet weak var labelMaxTemp: UILabel!
    @IBOutlet weak var labelMinTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setWeatherDate(for foreCast:DayForeCast) {
        
        // date formatter
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "EEEE"
        
        // set day label
        labelDayName.text = dateformatter.string(from: foreCast.weatherData.dt_text!)
        
        // Set image for weather condition
        let weatherData = foreCast.weatherData
        imageForeCast.image = UIImage.init(named: weatherData.weather!.first!.main! + ".png")
        
        // set day minimum tempeture
        if let max_main = foreCast.main.max(by: { $0.temp_max! > $1.temp_max! })  {
            labelMaxTemp.text = max_main.getMaxTempetureString()
        }
        
        // set day maximum tempeture
        if let min_main = foreCast.main.min(by: { $0.temp_min! > $1.temp_min! }) {
            labelMinTemp.text = min_main.getMinTempetureString()
        }
    }
}
