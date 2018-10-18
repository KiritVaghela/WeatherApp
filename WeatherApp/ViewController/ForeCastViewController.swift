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
    
    @IBOutlet weak var collectionViewForeCast: UICollectionView!
    @IBOutlet weak var tableViewDayForeCast: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = location.name
        
        collectionViewForeCast.dataSource = self
        
        showLoading()
        WeatherApiManager.shared.getFiveDayForeCast(forLatitude: "\(location.latitude)", longitude: "\(location.longitude)", success: { (forecastData) in
            self.hideLoading()
            self.foreCastData = forecastData
            
            self.collectionViewForeCast.reloadData()
            
            
            let dataFormatter = DateFormatter()
            dataFormatter.dateFormat = "yyyy-MM-dd"
            
            for weatherData in forecastData.weatherDataList!{
            
                var dict:[String:String] = [:]
                dict["temp"] = String(Int(weatherData.main!.temp!))
                dict["min"] = String(Int(weatherData.main!.temp_min!))
                dict["max"] = String(Int(weatherData.main!.temp_max!))
                
                let dateString = dataFormatter.string(from: weatherData.dt_text!)
                
                if let dayForeCast = self.arrayDayForeCast.filter({ $0.date == dateString}).first as? DayForeCast{
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
        
        tableViewDayForeCast.dataSource = self
        tableViewDayForeCast.delegate = self
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
        
        let foreCast = arrayDayForeCast[indexPath.row]
        
        cell.labelDayName.text = foreCast.date
        
        let weatherData = foreCast.weatherData
        cell.imageForeCast.image = UIImage.init(named: weatherData.weather!.first!.main! + ".png")
        
        let main = foreCast.main.max(by: { $0.temp! > $1.temp! })
        cell.labelDayTemp.text = String(Int(main!.temp!))
        
        return cell
    }
    
}

extension ForeCastViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
