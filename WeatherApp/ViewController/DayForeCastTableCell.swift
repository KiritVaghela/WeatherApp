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
    @IBOutlet weak var labelDayTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
