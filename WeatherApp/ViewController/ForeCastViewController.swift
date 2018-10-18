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
    var weatherData:WeatherData!
    var foreCastData: FiveDayForeCastData?
    
    @IBOutlet weak var collectionViewForeCast: UICollectionView!
    
    
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
            
        }) { (error) in
            self.hideLoading()
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

extension ForeCastCollectionViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 70)
        
    }
}
