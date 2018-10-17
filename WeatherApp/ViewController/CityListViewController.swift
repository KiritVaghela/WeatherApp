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
        
        self.btnCelcius.isSelected = true
        
        tableViewCityList.dataSource = self
        tableViewCityList.delegate = self
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
        self.btnFahrenheit.isSelected = false
        self.btnCelcius.isSelected = true
        
        self.tableViewCityList.reloadData()
    }
    
    @IBAction func btnFahrenheitTapped(_ sender: Any) {
        self.btnFahrenheit.isSelected = true
        self.btnCelcius.isSelected = false
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookmarkManager.shared.getLoctions().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityListTableViewCell
            
        cell.location = BookmarkManager.shared.getLoctions()[indexPath.row]
        cell.showFahrenheit = self.btnFahrenheit.isSelected
        
        if cell.weatherData == nil {
            if let lat = cell.location?.latitude, let lng = cell.location?.longitude {
                WeatherApiManager.shared.getWeatherData(forLatitude: "\(lat)", longitude: "\(lng)", success: { (weatherData) in
                    
                    cell.weatherData = weatherData
                    
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
}
