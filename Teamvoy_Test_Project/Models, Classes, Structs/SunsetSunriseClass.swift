//
//  Models.swift
//  Teamvoy_Test_Project
//
//  Created by Pavel Osipov on 11/21/19.
//  Copyright © 2019 Pavel Osipov. All rights reserved.
//

class SunsetSunrisePlace: Codable {
    var results : ResponseResult
}

class ResponseResult: Codable {
    var sunrise: String
    var sunset: String
}
