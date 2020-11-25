//
//  Utils.swift
//  CountriesTest
//
//  Created by yadin g on 24/11/2020.
//
import UIKit
import Foundation

extension Alertable where Self: UIViewController {
     func presentAlert(title: String? = nil, message: String, buttonTitle: String? = "OK") {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: buttonTitle, style: .default) {  (action) in }
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}

protocol Alertable {
      func presentAlert(title: String?, message: String, buttonTitle: String?)
}
