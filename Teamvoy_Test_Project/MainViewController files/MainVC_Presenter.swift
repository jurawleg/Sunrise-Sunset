//
//  MainVC_Presenter.swift
//  Teamvoy_Test_Project
//
//  Created by Pavel Osipov on 11/21/19.
//  Copyright © 2019 Pavel Osipov. All rights reserved.
//

import Foundation

// Можна було б розмежувати деякі методи на декілька протоколів, але поки їх небагато - нехай буде один
protocol MainVCDelegate {
    func showInfoOnLabel(text: String)
    func showResultOnLabel(text: String)
    func setTapGesture()
    func cleanAndHideLabel()
}

class MainVC_Presenter {
    
    init () {
        NotificationCenter.default.addObserver(self, selector: #selector(showInfo), name: .updateScreen, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showCustomPlaceInfo), name: .updateCustomPlaceInfo, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showResultOnLabel), name: .updateCityLabel, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .updateScreen, object: nil)
        NotificationCenter.default.removeObserver(self, name: .updateCityLabel, object: nil)
        NotificationCenter.default.removeObserver(self, name: .updateCustomPlaceInfo, object: nil)
    }
    
    var delegate: MainVCDelegate!
    
    @objc func showInfo() {
        dispatchTask {
            self.delegate.showInfoOnLabel(text: "Hello, dear user! \n" + GLOBAL_infoStorage.userLocationInfo)
        }
    }
    
    @objc func showCustomPlaceInfo() {
        
        guard let address = GLOBAL_infoStorage.citySearchResult?.formatted_address else {
            return
        }
        
        dispatchTask {
            self.delegate.showInfoOnLabel(text: "Hello, dear user! \nIn \(address) " + GLOBAL_infoStorage.customLocationInfo)
            self.delegate.cleanAndHideLabel()
            GLOBAL_infoStorage.citySearchResult = nil
            GLOBAL_infoStorage.customLocationInfo = ""
        }
    }
    
    @objc func showResultOnLabel() {
        
        dispatchTask {
            if let city = GLOBAL_infoStorage.citySearchResult {
                self.delegate.showResultOnLabel(text: city.formatted_address + "\nIs this the city you wanted to find? If yes - tap me ;-)")
                self.delegate.setTapGesture() // Ставимо тап гестур для подальшої роботи
            } else {
                self.delegate.showResultOnLabel(text: "Nothing found :-( \nTry one more time, please!")
            }
        }
        
    }
    
    func dispatchTask(completion: @escaping () -> ()) {
        DispatchQueue.main.async {
            completion()
        }
        
    }
}
