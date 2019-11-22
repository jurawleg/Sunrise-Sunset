//
//  MianVC_Extension.swift
//  Teamvoy_Test_Project
//
//  Created by Pavel Osipov on 11/22/19.
//  Copyright © 2019 Pavel Osipov. All rights reserved.
//

import UIKit
import Foundation

extension MainViewController: UITextFieldDelegate {
    
    func dismissKeyboardWhenTappingAround() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        gesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(gesture)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    
}
