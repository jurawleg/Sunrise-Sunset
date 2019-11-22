//
//  UserLocationService.swift
//  Teamvoy_Test_Project
//
//  Created by Pavel Osipov on 11/21/19.
//  Copyright © 2019 Pavel Osipov. All rights reserved.
//

import Foundation
import CoreLocation

class UserLocationManager {
    
    static var shared = UserLocationManager()
    
    var locationManager = CLLocationManager()
    
    var userLocLatitude : Double?
    var userLocLongitude : Double?
    
    var locationIsEnable : Bool {
        get {
            return userLocLatitude != nil && userLocLongitude != nil
        }
    }
    
    private init () {
        self.updateLocation()
    }
    
    func updateLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer // для світанку/заходу некритично ))
            locationManager.startUpdatingLocation()
            
            while userLocLatitude == nil && userLocLongitude == nil {
                
                guard let location: CLLocationCoordinate2D = locationManager.location?.coordinate else {
                    // показати еррору
                    return
                }
                userLocLatitude = location.latitude
                userLocLongitude = location.longitude
                locationManager.stopUpdatingLocation()
            }
            
        }
        
    }
    
}
