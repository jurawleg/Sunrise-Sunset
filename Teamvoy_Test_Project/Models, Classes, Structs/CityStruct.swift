//
//  CityStruct.swift
//  Teamvoy_Test_Project
//
//  Created by Pavel Osipov on 11/22/19.
//  Copyright © 2019 Pavel Osipov. All rights reserved.
//

import Foundation

struct FoundCity {
    
    var lat:         String = ""
    var lng:         String = ""
    var fullAddress: String = ""
    
    init(placeData: PlaceData) {
        self.lat = String(describing: placeData.geometry.location.lat)
        self.lng = String(describing: placeData.geometry.location.lng)
        self.fullAddress = placeData.formatted_address
    }
    
}
