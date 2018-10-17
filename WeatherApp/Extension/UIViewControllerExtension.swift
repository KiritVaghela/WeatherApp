//
//  UIViewControllerExtension.swift
//  WeatherApp
//
//  Created by Kirit Vaghela on 17/10/18.
//  Copyright © 2018 Kirit Vaghela. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

extension UIViewController {
    
    func showLoading(withStatus status:String = "") {
        if status.isEmpty {
            SVProgressHUD.show()
        }else{
            SVProgressHUD.show()
            SVProgressHUD.setStatus(status)
        }
    }
    
    func hideLoading() {
        SVProgressHUD.dismiss()
    }
    
}
