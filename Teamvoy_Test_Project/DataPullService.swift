//
//  DataPullService.swift
//  Teamvoy_Test_Project
//
//  Created by Pavel Osipov on 11/21/19.
//  Copyright © 2019 Pavel Osipov. All rights reserved.
//

import Foundation

protocol DataPullerProtocol {
    static func getPlaceByKeyword(keyWord: String)
}

class DataPullerService: DataPullerProtocol {
    
    static func getPlaceByKeyword(keyWord: String){
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "maps.googleapis.com"
        components.path = "/maps/api/place/textsearch/json"
        components.queryItems = [
            URLQueryItem(name: "key", value: String(describing: apiKey)),
            URLQueryItem(name: "query", value: keyWord)
        ]
        
        let session = URLSession(configuration: .default)
        var dataTask : URLSessionDataTask?
        
        guard let url = components.url else {
            // Error?
            return
        }
        
        dataTask?.cancel()
        
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
                    if let result = try? JSONDecoder().decode(PlaceStruct.self, from: data) {
                        
                        if !result.results.isEmpty {
                            debugPrint(result.results[0].formatted_address, " _ _ _ _ ", result.results[0].geometry.location)
                            GLOBAL_infoStorage.citySearchResult = result.results[0]
                        } else {
                            GLOBAL_infoStorage.citySearchResult = nil
                        }
                        NotificationCenter.default.post(name: .updateCityLabel, object: nil)

                    } else {
                        debugPrint("SOME WEIRD THINGS ARE HAPPENING - TROUBLE WITH JSON DESERIALISATION")
                        NotificationCenter.default.post(name: .unexpeсtedError, object: nil)
                        // Need to show some alarm for user
                        // Create special method for notificate user what happened
                    }
                    
                }
            }
            
        }
        
        dataTask?.resume()
        
        
        
        
        
    }
    
    
    
    
    
    
}
