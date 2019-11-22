//
//  ViewController.swift
//  Teamvoy_Test_Project
//
//  Created by Pavel Osipov on 11/21/19.
//  Copyright © 2019 Pavel Osipov. All rights reserved.
//

import UIKit
import GooglePlaces
import CoreLocation
import Foundation



//
//
//
//
//
//
//
//
// Привіт!
// Хотів прикрутити таблицю з аутокомпліт від гугла - але не вистачило часу, та й бесплатний аккаунт ріже автокомпліт після 3-5 підтягувань та заставляє чекати пару хвилин для відпочинку ))
// Не все красиво у цій апці - але не було надто багато часу, та й основна робота також повинна робитись ))
// Хотів прикрутити протоколи та юніт-тестування, почистити трішки тут все та зробити більш явним і зрозумілим.
// Не все допиляно було що хотів, але основний функціонал +- дихає
// Буду радий відгукам!
//
//
// Єдине що мене бентежило - данні по схід/захід некорректні (захід - показує нормально, а от схід сонця АПІшка повертає мені надто ранній)
// Не знаю в чому справа, конвертація походу норм працює, а от правильність данних від АПІ - під підозрою.
//
//
//
//
//
//


class MainViewController: UIViewController, MainVCDelegate {
    
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var cityWasFoundLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    
    var presenter: MainVC_Presenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MainVC_Presenter()
        presenter.delegate = self
        
        SunService.getInfoAboutSunForUserLocation()
        
        dismissKeyboardWhenTappingAround()
        searchTextField.delegate = self
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.infoLabel.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
    
    func showInfoOnLabel(text: String) {
        self.infoLabel.text = text
    }
    
    func showResultOnLabel(text: String) {
        self.cityWasFoundLabel.text = text
    }
    
    @objc func getInfo(){
        SunService.getInfoForCustomLocation(lat: (GLOBAL_infoStorage.citySearchResult?.geometry.location.lat)!, lng: (GLOBAL_infoStorage.citySearchResult?.geometry.location.lng)!)
    }
    
    func setTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(getInfo))
        self.cityWasFoundLabel.addGestureRecognizer(tapGesture)
    }
    
    func cleanAndHideLabel() {
        self.cityWasFoundLabel.text = ""
        self.searchTextField.text = ""
    }
    
    @IBAction func searchPlace(_ sender: Any) {
        if searchTextField.text!.count > 2 {
            // Moжна було перемістити виклик до сервісу в презентер (або ще кудись, в окремий менеджер викликів :-) ) але не було особливої потреби
            DataPullerService.getPlaceByKeyword(keyWord: searchTextField.text!)
        }
    }
    
    @IBAction func showInfoForUserLocation(_ sender: Any) {
       SunService.getInfoForLocation(lat: nil, lng: nil)
    }
    
}

