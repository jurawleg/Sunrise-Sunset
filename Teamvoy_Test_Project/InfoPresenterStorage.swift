//
//  InfoStorage.swift
//  Teamvoy_Test_Project
//
//  Created by Pavel Osipov on 11/22/19.
//  Copyright © 2019 Pavel Osipov. All rights reserved.
//

import Foundation

struct InfoPresenterStorage {
    
    var userLocationInfo:    String = ""
    var customLocationInfo:  String = ""
    var citySearchResult :   PlaceData?
    
    init () {
        self.setVariablesToDefaultState()
    }
    
    mutating func setUserLocationInfo(sunrise: String, sunset: String) {
        
        if sunrise != "" && sunset != "" {
            var tempSunrise = DateConverter.convertToUSerTM(date: sunrise)
            var tempSunset = DateConverter.convertToUSerTM(date: sunset)
            self.userLocationInfo = "Sunrise in this place will be at \(tempSunrise), sunset - at \(tempSunset)"
        }
        
    }
    
    mutating func setCustomLocationInfo(sunrise: String, sunset: String) {
        
        if sunrise != "" && sunset != "" {
            var tempSunrise = DateConverter.convertToUSerTM(date: sunrise)
            var tempSunset = DateConverter.convertToUSerTM(date: sunset)
            self.customLocationInfo = "sunrise will be at \(tempSunrise), sunset - at \(tempSunset)"
        }
        
    }
    
    mutating func setVariablesToDefaultState() {
        self.userLocationInfo = "Sorry, something went wrong! \nCannot find info for place where you are now."
        self.customLocationInfo = "Sorry, something went wrong! \nCannot find info for this place."
        self.citySearchResult = nil
    }
    
}

class DateConverter {
    
    static func convertToUSerTM(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss a"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "HH:mm:ss a"
            
        let timezoneOffset = TimeZone.current.secondsFromGMT()
        var convDate = dt!.timeIntervalSince1970
        let calculatedDateOffset = (convDate + Double(timezoneOffset))
        let timeZoneOffsetDate = Date(timeIntervalSince1970: calculatedDateOffset)

        return dateFormatter.string(from: timeZoneOffsetDate)

    }
    
    
    
}
