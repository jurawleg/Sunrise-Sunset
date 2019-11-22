//
//  NotificationExtension.swift
//  Teamvoy_Test_Project
//
//  Created by Pavel Osipov on 11/22/19.
//  Copyright © 2019 Pavel Osipov. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let updateScreen = Notification.Name("UpdateScreen")
    static let updateCityLabel = Notification.Name("UpdateCityLabel")
    static let updateCustomPlaceInfo = Notification.Name("UpdateCustomPlaceInfo")
    static let troublesWithLocationService = Notification.Name("TroublesWithLocationService")
    static let unexpeсtedError = Notification.Name("UnexpeсtedError")
}
