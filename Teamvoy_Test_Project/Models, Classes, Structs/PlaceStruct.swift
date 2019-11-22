//
//  PlaceStruct.swift
//  Teamvoy_Test_Project
//
//  Created by Pavel Osipov on 11/22/19.
//  Copyright © 2019 Pavel Osipov. All rights reserved.
//

//import Foundation

struct PlaceStruct: Codable {
    var results: [PlaceData]
}

struct PlaceData: Codable {
    var formatted_address: String
    var geometry: Geometry
}

struct Geometry: Codable {
    var location: Location
}

struct Location: Codable {
    var lat : Double
    var lng : Double
}

