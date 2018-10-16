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
        var params = [String:Any]()
        params["lat"] = "0"
        params["lon"] = "0"
        params["appid"] = "c6e381d8c7ff98f0fee43775817cf6ad"
        params["units"] = "metric"

        let url = "http://api.openweathermap.org/data/2.5/weather"
        
        NetworkManager.shared.makeSimpleRequest(requestMethod: httpGet, withApiUrl: url, params: params, success: { (message) in
            
            
            
        }) { (error) in
            print(error)
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
