//
//  ForeCastViewController.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 17/10/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import UIKit

class ForeCastViewController: UIViewController {

    var location:Location!
    var foreCastData: FiveDayForeCastData?
    var arrayDayForeCast:[DayForeCast] = Array<DayForeCast>()
    
    
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelCondtion: UILabel!
    
    @IBOutlet weak var collectionViewForeCast: UICollectionView!
    @IBOutlet weak var tableViewDayForeCast: UITableView!
    @IBOutlet weak var labelTempeture: UILabel!
    

    @IBOutlet weak var labelSunrise: UILabel!
    @IBOutlet weak var labelSunset: UILabel!
    @IBOutlet weak var labelRainChance: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelWindSpeed: UILabel!
    @IBOutlet weak var labelPressure: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "5 Day Forecast"
        
        // set city name label
        self.labelCityName.text = location.name
        
        // set weather condtion label
        self.labelCondtion.text = location.weatherData?.weather?.first?.main ?? ""
        
        // set tepmeture
        self.labelTempeture.text = String(Int((location.weatherData?.main?.temp)!))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mma"
        
        // set footer data like sunrise, sunset, rain chance, humidity
        // sunrise
        if let sunriseDate = location.weatherData?.sys?.sunrise {
            self.labelSunrise.text =  dateFormatter.string(from: sunriseDate)
        }
        
        // sunset
        if let sunsetDate = location.weatherData?.sys?.sunset {
            self.labelSunset.text = dateFormatter.string(from: sunsetDate)
        }
        
        //chance of rain
        self.labelRainChance.text = "\(location.weatherData?.clouds?.all ?? 0)%"
        
        // humidity
        self.labelHumidity.text = "\(location.weatherData?.main?.humidity ?? 0)%"
        
        // wind speed
        self.labelWindSpeed.text = String(format: "%.1fkm/hr", location.weatherData?.wind?.speed ?? 0)
        
        // pressure
        self.labelPressure.text = "\(Int(location.weatherData?.main?.pressure ?? 0)) hPa"
        
        // dataset and delegate
        collectionViewForeCast.dataSource = self
        tableViewDayForeCast.dataSource = self
        tableViewDayForeCast.delegate = self
        
        // get forecast for current city
        getFiveDayForecast()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // Get Five Day forcast
     */
    fileprivate func getFiveDayForecast() {
        showLoading()
        WeatherApiManager.shared.getFiveDayForeCast(forLatitude: "\(location.latitude)", longitude: "\(location.longitude)", success: { (forecastData) in
            self.hideLoading()
            self.foreCastData = forecastData
            
            self.collectionViewForeCast.reloadData()
            
            
            let dataFormatter = DateFormatter()
            dataFormatter.dateFormat = "yyyy-MM-dd"
            
            for weatherData in forecastData.weatherDataList!{
                
                let dateString = dataFormatter.string(from: weatherData.dt_text!)
                
                if let dayForeCast = self.arrayDayForeCast.filter({ $0.date == dateString}).first {
                    dayForeCast.main.append(weatherData.main!)
                }else{
                    self.arrayDayForeCast.append(DayForeCast(date: dateString, main: [weatherData.main!], weatherData: weatherData))
                }
            }
            
            self.tableViewDayForeCast.reloadData()
            
            
        }) { (error) in
            self.hideLoading()
            print(error.localizedDescription)
        }
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

extension ForeCastViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = foreCastData {
            return data.weatherDataList?.count ?? 0
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forecastCell", for: indexPath) as! ForeCastCollectionViewCell
        
        let forecast = foreCastData!.weatherDataList![indexPath.row]
        
        cell.setForeCast(data: forecast)
        
        return cell
    }
    
    
}


extension ForeCastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDayForeCast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayForeCastCell", for: indexPath) as! DayForeCastTableCell
        
        // get day forcast
        let foreCast = arrayDayForeCast[indexPath.row]
        
        // set ui
        cell.setWeatherDate(for: foreCast)
        
        return cell
    }
    
}

extension ForeCastViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
