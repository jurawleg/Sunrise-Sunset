//
//  SunService.swift
//  Teamvoy_Test_Project
//
//  Created by Pavel Osipov on 11/21/19.
//  Copyright © 2019 Pavel Osipov. All rights reserved.
//

import Foundation

class SunService {
    
    static func getInfoAboutSunForUserLocation() {
        
        if LocationService.locationIsEnable {
            self.getInfoForLocation(lat: nil, lng: nil)
        } else {
            // Alarm?
            NotificationCenter.default.post(name: .troublesWithLocationService, object: nil, userInfo: nil)
        }
        
    }
    
    static func getInfoForCustomLocation(lat: Double, lng: Double) {
        getInfoForLocation(lat: lat, lng: lng)
    }
    
    class func getInfoForLocation(lat: Double?, lng: Double?) {
        
        // Можна було спробувати прописати в параметрах якісь значення по замовчуванню або ще щось
        // Але вирішив зробити тернарні оператори в query items
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.sunrise-sunset.org"
        components.path = "/json"
        components.queryItems = [
            URLQueryItem(name: "lat", value: lat == nil ? String(describing: LocationService.userLocLatitude!) : String(describing: lat!)),
            URLQueryItem(name: "lng", value: lng == nil ? String(describing: LocationService.userLocLongitude!) : String(describing: lng!)),
//            URLQueryItem(name: "formatted", value: "0")
        ]
        
        let session = URLSession(configuration: .default)
        var dataTask : URLSessionDataTask?
        
        guard let url = components.url else {
            // Error?
            return
        }
        
        dataTask?.cancel()
        
        debugPrint(components.url!)
        
        dataTask = session.dataTask(with: url) { data, response, error in
            
            defer {
//                    dataTask = nil
            }
            
            if let error = error {
                debugPrint("DATA TASK ERROR - \(error.localizedDescription)")
                NotificationCenter.default.post(name: .unexpeсtedError, object: nil, userInfo: nil)
                // Need to show some alarm for user
                // Create special method for notificate user what happened
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                DispatchQueue.main.async {
                    if let result = try? JSONDecoder().decode(SunsetSunrisePlace.self, from: data) {
                        
                        // Не дуже розумна перевірка для того щоб записати або інфо для юзер локейшн або для кастом локейшн
                        // Вартувало б якось грамотніше написати виклик метода та розділити цей функціонал
                        // Можливо в наступній ітерації апки я це продумаю
                        if lat == nil && lng == nil {
                            GLOBAL_infoStorage.setUserLocationInfo(sunrise: result.results.sunrise, sunset: result.results.sunset)
                            NotificationCenter.default.post(name: .updateScreen, object: nil, userInfo: nil)
                        } else {
                            GLOBAL_infoStorage.setCustomLocationInfo(sunrise: result.results.sunrise, sunset: result.results.sunset)
                            NotificationCenter.default.post(name: .updateCustomPlaceInfo, object: nil, userInfo: nil)
                        }
                    
                    } else {
                        debugPrint("SOME WEIRD THINGS ARE HAPPENING - TROUBLE WITH JSON DESERIALISATION")
                        NotificationCenter.default.post(name: .unexpeсtedError, object: nil, userInfo: nil)
                        // Need to show some alarm for user
                        // Create special method for notificate user what happened
                    }
                    
                }
            }
            
        }
        
        dataTask?.resume()
        
    }
    
    
    
    
}
