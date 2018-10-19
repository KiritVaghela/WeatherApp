//
//  CityListViewController.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 10/15/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import UIKit
import LocationPickerViewController

class CityListViewController: UIViewController {

    @IBOutlet weak var tableViewCityList: UITableView!
    @IBOutlet weak var btnCelcius: UIButton!
    @IBOutlet weak var btnFahrenheit: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Places : \(BookmarkManager.shared.getLoctions().count)")
        
        setTempUnitType()
        
        tableViewCityList.dataSource = self
        tableViewCityList.delegate = self
        
    }

    func setTempUnitType() {
        switch WeatherApiManager.shared.unitType {
            
        case .kelvin:
            btnCelcius.isSelected = false
            btnFahrenheit.isSelected = false
            
        case .metric:
            btnCelcius.isSelected = true
            btnFahrenheit.isSelected = false
            
        case .imperial:
            btnFahrenheit.isSelected = true
            btnCelcius.isSelected = false
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addLocationTap(_ sender: Any) {
     
        let locationPicker = LocationPicker()
        locationPicker.pickCompletion = { (pickedLocationItem) in

            // Do something with the location the user picked.
            if let lat = pickedLocationItem.coordinate?.latitude, let lng = pickedLocationItem.coordinate?.longitude, let city = pickedLocationItem.addressDictionary!["City"] as? String {
                
                let location = Location(name: city, latitude: lat, longitude: lng)
                BookmarkManager.shared.addLoation(location: location)
                
                self.tableViewCityList.reloadData()

            }
        }
        navigationController!.pushViewController(locationPicker, animated: true)
    }
    
    @IBAction func btnCelciusTapped(_ sender: Any) {
    
        if WeatherApiManager.shared.unitType == .metric {
            return
        }
        
        for location in BookmarkManager.shared.getLoctions() {
            location.weatherData = nil
        }

        WeatherApiManager.shared.unitType = .metric
        self.setTempUnitType()
        self.tableViewCityList.reloadData()
    }
    
    @IBAction func btnFahrenheitTapped(_ sender: Any) {
        
        if WeatherApiManager.shared.unitType == .imperial {
            return
        }
       
        for location in BookmarkManager.shared.getLoctions() {
            location.weatherData = nil
        }
        
        WeatherApiManager.shared.unitType = .imperial
        self.setTempUnitType()
        self.tableViewCityList.reloadData()
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

extension CityListViewController : UITableViewDataSource {
    
    // allow row edit for delete functionallity
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let locations = BookmarkManager.shared.getLoctions()
            
            //1. get location
            let currentLocation = locations[indexPath.row]
            
            //2. remove from list
            BookmarkManager.shared.removeLocation(location: currentLocation)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookmarkManager.shared.getLoctions().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityListTableViewCell
        
        cell.location = BookmarkManager.shared.getLoctions()[indexPath.row]
        
        if cell.location?.weatherData == nil {
            if let lat = cell.location?.latitude, let lng = cell.location?.longitude {
                WeatherApiManager.shared.getWeatherData(forLatitude: "\(lat)", longitude: "\(lng)", success: { (weatherData) in
                    
                    cell.location?.weatherData = weatherData
                    
                    cell.updateUI()
                    
                }, failure: { (error) in
                    print(error.localizedDescription)
                })
            }
        }
        
        cell.updateUI()
        
        return cell
    }
}

extension CityListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let _ = BookmarkManager.shared.getLoctions()[indexPath.row].weatherData {
            self.performSegue(withIdentifier: "toForeCastScreen", sender: indexPath)
        }
    }
}


extension CityListViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toForeCastScreen" {
            
            if let indexPath = sender as? IndexPath {
                
                let location = BookmarkManager.shared.getLoctions()[indexPath.row]
                if let forecaseScreen = segue.destination as? ForeCastViewController {
                    forecaseScreen.location = location
                }
            }
        }
    }
}
