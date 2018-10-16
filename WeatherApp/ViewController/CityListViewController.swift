//
//  CityListViewController.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 10/15/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import UIKit

class CityListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
     
        WeatherApiManager.shared.getWeatherData(forLatitude: "0", longitude: "0", success: { (weatherData) in
            print(weatherData.toJSONString(prettyPrint: true))
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
